//
//  ResultModel.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation

struct ResultModel: Codable {
    let title: String
    let overview: String
    let id: Int
    let backdropPath: String?
    let posterPath: String?
    var releaseDate: String?
    let starCount: Double?
    let imdbId: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, overview, id, backdropPath = "backdrop_path", posterPath = "poster_path", releaseDate = "release_date", starCount = "vote_average", imdbId = "imdb_id"
    }
}


