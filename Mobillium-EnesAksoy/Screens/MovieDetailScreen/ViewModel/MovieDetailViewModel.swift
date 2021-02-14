//
//  MovieDetailViewModel.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

class MovieDetailViewModel: NSObject {
    
    // MARK: - Proporties
    private let movieDetailEndPoint = "/movie/\(ObjectStore.shared.movieId ?? 0)"
    private let similarMoviesEndPoint = "/movie/\(ObjectStore.shared.movieId ?? 0)/similar"
    private var apiService: APIService!
    private var movieDetailResponse: ResultModel?
    private var similarMoviesResponse: ResponseModel?
    private var error: String = ""
    
    var delegate: MovieDetailViewModelDelegate?
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.getMovieDetailData()
    }
    
    // MARK: - Service Call Methods
    private func getMovieDetailData() {
        apiService.apiToGetData(isResult: false, endPoint: self.movieDetailEndPoint) { [weak self] _, error, responseModel in
            guard let self = self else { return }
            if var response = responseModel, error.isEmpty {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let releaseDate = dateFormatter.date(from: (response.releaseDate)!) ?? Date()
                dateFormatter.dateFormat = "dd.MM.yy"
                let myString = dateFormatter.string(from: releaseDate)
                response.releaseDate = myString
                self.movieDetailResponse = response
                self.getSimilarMoviesData()
                return
            }
            self.error = error
        }
    }
    
    private func getSimilarMoviesData() {
        apiService.apiToGetData(endPoint: self.similarMoviesEndPoint) { [weak self] responseModel, error, _ in
            guard let self = self else { return }
            if let response = responseModel, error.isEmpty {
                self.similarMoviesResponse = response
            }
            self.error = error
            
            self.delegate?.updateView(movieDetailResponse: self.movieDetailResponse,
                                      similarMoviesData: self.similarMoviesResponse,
                                     errorText: self.error)
        }
    }
}
