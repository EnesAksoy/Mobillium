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

    // MARK: - Outlets
    @IBOutlet weak var imagePoster: UIImageView! {
        didSet {
            imagePoster.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configure Cell Method
    
    func configureCell(posterUrl: String, title: String, description: String, date: String) {
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/w500\(posterUrl)")
        self.imagePoster.kf.indicatorType = .activity
        self.imagePoster.kf.setImage(with: posterUrl)
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.dateLabel.text = date
    }
    
}
