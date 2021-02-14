//
//  SearchViewController.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Constans
    
    private let searchListTableViewCellId = "SearchListTableViewCell"
    private let notificationIdentifierName = "NotificationIdentifier"
    private let endPoint = "/search/movie"
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: self.searchListTableViewCellId, bundle: nil),
                               forCellReuseIdentifier: self.searchListTableViewCellId)
        }
    }
    
    // MARK: - Proporties
    
    private var viewModel: ListScreenViewController!
    private var response: ResponseModel?
    private var apiService: APIService!
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiService = APIService()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.methodOfReceivedNotification(notification:)),
                                               name: Notification.Name("\(self.notificationIdentifierName)"),
                                               object: nil)
    }
    
    // MARK: - Notification Method
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        let searchText = notification.object! as! String
        let newSearhcText = searchText.replacingOccurrences(of: " ", with: "+")
        apiService.apiToGetData(search: newSearhcText,
                                endPoint: self.endPoint) { [weak self] response, errorString, _ in
                                    self?.response = response
                                    self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView Delegate Methods

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.response?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.searchListTableViewCellId, for: indexPath) as! SearchListTableViewCell
        cell.cellConfiguration(title: self.response?.results[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ObjectStore.shared.movieId = self.response?.results[indexPath.row].id
        let vc = MovieDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
