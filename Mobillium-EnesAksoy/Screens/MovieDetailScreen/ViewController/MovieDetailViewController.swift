//
//  MovieDetailViewController.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    // MARK: - Proporties
    private var viewModel: MovieDetailViewModel!
    private var movieDetailResponse: ResultModel?
    private var similarMoviesData: ResponseModel?
    
    // MARK: - Constants
       private let errorKey = "MessageTitle1"
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            LoadingView.showLoadingView()
        }
        self.navigationController?.isNavigationBarHidden = false
        self.viewModel = MovieDetailViewModel()
        self.viewModel.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "SimilarMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarMoviesCollectionViewCell")
    }
    
    //MARK:- Actions
    @IBAction func imdbButtonClicked(_ sender: Any) {
        ObjectStore.shared.imdbId = self.movieDetailResponse?.imdbId
        let vc = WebViewScreenController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Functions
    private func updateView() {
        self.posterImage.kf.indicatorType = .activity
        let urlPoster = URL(string: "https://image.tmdb.org/t/p/w500\(self.movieDetailResponse?.backdropPath ?? "")")
        self.posterImage.kf.setImage(with: urlPoster, placeholder: UIImage(named: "placeholder"))
        self.movieTitle.text = self.movieDetailResponse?.title
        self.movieDescription.text = self.movieDetailResponse?.overview
        self.starCountLabel.text = "\(self.movieDetailResponse?.starCount ?? 0)"
        self.dateLabel.text = self.movieDetailResponse?.releaseDate
        self.collectionView.reloadData()
    }
    
    
}

// MARK:- Movie Detail View Model Delegate
extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func updateView(movieDetailResponse: ResultModel?, similarMoviesData: ResponseModel?, errorText: String) {
        LoadingView.removeLoadingView()
        if !errorText.isEmpty {
            self.createAlert(message: errorText, title: self.localizableGetString(forkey: self.errorKey))
        }else {
            self.movieDetailResponse = movieDetailResponse
            self.similarMoviesData = similarMoviesData
            self.updateView()
        }
    }
}

//MARK: - UICollectionView Delegate Methods
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarMoviesData?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMoviesCollectionViewCell", for: indexPath) as! SimilarMoviesCollectionViewCell
        cell.cellConfigure(movieTitle: self.similarMoviesData?.results[indexPath.row].title ?? "",
                           date: self.similarMoviesData?.results[indexPath.row].releaseDate ?? "",
                           moviePoster: self.similarMoviesData?.results[indexPath.row].posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lenght = self.collectionView.frame.height
        return CGSize(width: 70, height: lenght)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
