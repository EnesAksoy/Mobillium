//
//  MobilliumView.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation
import UIKit

class MobilliumView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.backgroundColor = .systemGray5
        }
    }
}

