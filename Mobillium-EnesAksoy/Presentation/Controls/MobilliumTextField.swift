//
//  MobilliumTextField.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation
import UIKit

class MobilliumTextField: UITextField {
    @IBInspectable var localizableKey: String? = nil {
        didSet {
            if localizableKey != nil {
                self.placeholder = NSLocalizedString(localizableKey!, comment: "")
                self.textColor = .darkGray
            }
        }
    }
}
