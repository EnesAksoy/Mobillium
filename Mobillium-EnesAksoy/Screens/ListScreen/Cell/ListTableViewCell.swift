//
//  ListTableViewCell.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {
    
    // MARK: - Constans
    
    private let posterBaseUrl = "https://image.tmdb.org/t/p/w500"
    private let imageCornerRadius: CGFloat = 6
    private let placeholderText = "placeholder"
    
    // MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var imagePoster: UIImageView! {
        didSet {
            imagePoster.layer.cornerRadius = self.imageCornerRadius
        }
    }
    
    // MARK: - Configure Cell Method
    
    func configureCell(posterUrl: String, title: String, description: String, date: String) {
        let posterUrl = URL(string: "\(self.posterBaseUrl)\(posterUrl)")
        self.imagePoster.kf.indicatorType = .activity
        self.imagePoster.kf.setImage(with: posterUrl, placeholder: UIImage(named: placeholderText))
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.dateLabel.text = date
    }
    
}
