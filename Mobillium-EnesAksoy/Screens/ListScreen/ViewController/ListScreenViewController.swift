//
//  ListScreenViewController.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit
import Kingfisher

class ListScreenViewController: UIViewController {
    
    // MARK: - Constans
    
    private let listTableViewCellId = "ListTableViewCell"
    private let sliderViewNibName = "SliderView"
    private let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    private let notificationName = "NotificationIdentifier"
    private let zeroInt = 0
    private let zeroCGFloat: CGFloat = 0
    
    // MARK: - Outlests
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var subSliderView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchListView: UIView!
    
    // MARK: - Properties
    
    private var viewModel: ListScreenViewModel!
    private let searchView = SearchViewController()
    private var nowPlayingData: ResponseModel?
    private var upComingData: ResponseModel?
    private var apiService: APIService!
    private var newString: String = ""
    private var slides = [SliderView]()

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiService = APIService()
        self.viewModel = ListScreenViewModel()
        self.getObjectStoreData()
        self.scrollView.delegate = self
        self.searchTextField.delegate = self
        self.pageControllerConfiguration()
        self.slides = self.sliders()
        setSliderView(slides: self.slides)
        self.tableViewConfiguration()
        self.tableView.reloadData()
        self.searchListView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Get Object Store Data
    
    private func getObjectStoreData() {
        self.viewModel.getObjectStoreData { nowPlayingData, upComingData in
            self.nowPlayingData = nowPlayingData
            self.upComingData = upComingData
        }
    }
    
    // MARK: - Table View Configuration
    
    private func tableViewConfiguration() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: self.listTableViewCellId, bundle: nil),
                                forCellReuseIdentifier: self.listTableViewCellId)
    }
    
    // MARK: - Page Controller Configuration
    
     private func pageControllerConfiguration() {
        self.pageControl.numberOfPages = (nowPlayingData?.results.count)!
        self.pageControl.currentPage = self.zeroInt
        self.pageControl.currentPageIndicatorTintColor = .white
        self.pageControl.pageIndicatorTintColor = .lightGray
    }
    
    // MARK: - Set Slider View
    
    private func setSliderView(slides: [SliderView]) {
        self.scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(slides.count), height: self.subSliderView.frame.height)
        for i in self.zeroInt ..< slides.count {
            slides[i].frame = CGRect(x: view.bounds.width * CGFloat(i),
                                     y: self.zeroCGFloat,
                                     width: scrollView.frame.width,
                                     height: self.subSliderView.frame.height)
            self.scrollView.addSubview(slides[i])
        }
    }
    
    // MARK: - Slider Page Create Method
    
    private func sliders() -> [SliderView] {
        for i in 0...((self.nowPlayingData?.results.count)! - 1) {
            let slide: SliderView = Bundle.main.loadNibNamed(self.sliderViewNibName,
                                                             owner: self,
                                                             options: nil)?.first as! SliderView
            let imageUrl = URL(string: "\(self.imageBaseUrl)\(nowPlayingData?.results[i].backdropPath ?? "")")
            slide.descriptionLabel.text = nowPlayingData?.results[i].title
            slide.imageView.kf.indicatorType = .activity
            slide.imageView.kf.setImage(with: imageUrl)
            slides.append(slide)
        }
        return slides
    }
    
    // MARK: - Add Subview
    
    private func searchTableViewAddSubview() {
        self.dismissSearchView()
        self.searchListView.isHidden = false
        self.addChild(searchView)
        searchView.view.center = self.searchListView.center
        searchView.view.frame = self.searchListView.frame
        searchView.view.tag = 5252
        self.searchListView.addSubview(searchView.view)
        searchView.didMove(toParent: self)
    }
    
    // MARK: - Dismiss Search View
    
    private func dismissSearchView() {
        if let viewWithTag = self.view.viewWithTag(5252) {
            viewWithTag.removeFromSuperview()
        }
        self.searchListView.isHidden = true
    }
}

// MARK: - ScrollView Delegate

extension ListScreenViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
            pageControl.currentPage = Int(pageIndex)
            if scrollView.contentOffset.y != 0 {
                scrollView.contentOffset.y = 0
            }
        }
    }
}

// MARK: - UITableView Methods

extension ListScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.upComingData?.results.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.listTableViewCellId,
                                                 for: indexPath) as! ListTableViewCell
        cell.configureCell(posterUrl: (self.upComingData?.results[indexPath.row].posterPath)!,
                           title: (self.upComingData?.results[indexPath.row].title)!,
                           description: (self.upComingData?.results[indexPath.row].overview)!,
                           date: (self.upComingData?.results[indexPath.row].releaseDate)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ObjectStore.shared.movieId = self.upComingData?.results[indexPath.row].id
        let vc = MovieDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK:- UITextFieldDelegate Method

extension ListScreenViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentString: NSString = textField.text! as NSString
        var replacedString: String?
        let newString: NSString = currentString.replacingCharacters(in: range, with: replacedString ?? "\(string)") as NSString
        
        if newString.length >= 2 {
            
            replacedString = string.replacingOccurrences(of: " ", with: "+")
            searchListView.isHidden = false
            NotificationCenter.default.post(name: Notification.Name(self.notificationName), object: newString as String)
            self.searchTableViewAddSubview()
        } else if newString.length == 0 {
            self.dismissSearchView()
        }
        return true
    }
}

 
