//
//  SimilarMoviesCollectionViewCell.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit

class SimilarMoviesCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!{
        didSet {
            posterImage.layer.cornerRadius = 6
            posterImage.layer.masksToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK:- Cell Configure
    func cellConfigure(movieTitle: String, date: String, moviePoster: String) {
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(moviePoster)")
        self.posterImage.kf.indicatorType = .activity
        self.posterImage.kf.setImage(with: posterUrl)
        self.movieTitle.text = movieTitle
        
        self.yearLabel.text = "(\(substring(x: 0, y: 4, s: date)))"
    }
    
    private func substring(x : Int, y : Int, s : String) -> String {
      let start = s.index(s.startIndex, offsetBy: x)
      let end   = s.index(s.startIndex, offsetBy: y)
      return String(s[start..<end])
    }

}
