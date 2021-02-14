//
//  SliderView.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit

class SliderView: UIView {

    // MARK: - Outlests
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .white
        }
    }
}
