//
//  ListScreenViewModel.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

class ListScreenViewModel: NSObject {
    
    // MARK: - Constans
    
    private let dateFormat = "yyyy-MM-dd"
    private let newDateFormat = "dd.MM.yy"
    
    // MARK: - Life Cycles
    
    override init() {
        super.init()
    }
    
    // MARK: - Get ObjectStore Data
    
    func getObjectStoreData(completion: @escaping(_ nowPlayingData: ResponseModel?, _ upComingData: ResponseModel?) -> Void) {
        
        if let nowPlayingData = ObjectStore.shared.nowPlayingData, var upComingData = ObjectStore.shared.upComingData {
            
            for (index, result) in upComingData.results.enumerated() {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = self.dateFormat
                let releaseDate = dateFormatter.date(from: result.releaseDate!) ?? Date()
                dateFormatter.dateFormat = self.newDateFormat
                let myString = dateFormatter.string(from: releaseDate)
                upComingData.results[index].releaseDate = myString
                ObjectStore.shared.upComingData = upComingData
            }
            completion(nowPlayingData, upComingData)
        }
    }
}
