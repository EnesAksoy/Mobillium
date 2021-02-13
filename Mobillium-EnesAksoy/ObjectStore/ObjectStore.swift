//
//  ObjectStore.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

class ObjectStore {
    
    static let shared = ObjectStore()
    
    var nowPlayingData: ResponseModel?
    var upComingData: ResponseModel?
}

