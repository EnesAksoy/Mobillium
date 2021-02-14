//
//  MovieDetailViewModelDelegate.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelDelegate {
    func updateView(movieDetailResponse: ResultModel?, similarMoviesData: ResponseModel?, errorText: String)
}
