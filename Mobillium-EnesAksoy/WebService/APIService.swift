//
//  APIService.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation
import Alamofire

class APIService:  NSObject {
    
    private let baseUrlString = "https://api.themoviedb.org/3"
    private let apikey = "283d41c0628d9e3fa8d6b97935ca5220"
    private let resultModel: [ResultModel] = []
    
    func apiToGetData(isResult: Bool = true, search: String = "", endPoint: String, completion : @escaping (_ responseModel: ResponseModel?, _ error: String, _ resultModel: ResultModel?) -> ()) {
        var apiUrl = "\(baseUrlString)\(endPoint)?api_key=\(apikey)"
        
        if search != "" {
            apiUrl = "\(baseUrlString)\(endPoint)?api_key=\(apikey)&query=\(search)"
        }
        
        Alamofire.request(apiUrl).response { response in
            guard let data = response.data else {
                completion(nil, response.error?.localizedDescription ?? "nil data", nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if !isResult {
                    let response = try decoder.decode(ResultModel.self, from: data)
                    completion(nil, "", response)
                }
                let response = try decoder.decode(ResponseModel.self, from: data)
                completion(response, "", nil)
            } catch let error {
                completion(nil, error.localizedDescription, nil)
            }
        }
    }
}

