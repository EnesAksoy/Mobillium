//
//  SplashScreenViewModelDelegate.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

protocol SplashScreenViewModelDelegate {
    
    func updateView(nowPlayingData: ResponseModel?, upComingData: ResponseModel?, errorText: String)
}
