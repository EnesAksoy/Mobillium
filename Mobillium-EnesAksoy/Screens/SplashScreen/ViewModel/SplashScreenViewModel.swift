//
//  SplashScreenViewModel.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

class SplashScreenViewModel: NSObject {
    
    // MARK: - Constans
    
    private let nowPlayingEndPoint = "/movie/now_playing"
    private let upComingEndPoint = "/movie/upcoming"
    
    // MARK: - Delegate
    
    var delegate: SplashScreenViewModelDelegate?
    
    // MARK: - Properties
    
    private var apiService: APIService!
    private var nowPlayingResponse: ResponseModel?
    private var upComingResponse: ResponseModel?
    private var error: String = ""
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.getNowPlayingData()
    }
    
    // MARK: - Service Call Methods
    
    private func getNowPlayingData() {
        apiService.apiToGetData(endPoint: self.nowPlayingEndPoint) { [weak self] responseModel, error in
            guard let self = self else { return }
            if let response = responseModel, error.isEmpty {
                self.nowPlayingResponse = response
                self.getUpComingData()
                return
            }
            self.error = error
        }
    }
    
    private func getUpComingData() {
        apiService.apiToGetData(endPoint: self.upComingEndPoint) { [weak self] responseModel, error in
            guard let self = self else { return }
            if let response = responseModel, error.isEmpty {
                self.upComingResponse = response
            }
            self.error = error
            self.delegate?.updateView(nowPlayingData: self.nowPlayingResponse,
                                      upComingData: self.upComingResponse,
                                      errorText: self.error)
        }
    }
}

