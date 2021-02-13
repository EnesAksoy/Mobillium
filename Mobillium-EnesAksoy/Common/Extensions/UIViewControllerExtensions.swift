//
//  UIViewControllerExtensions.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    func createAlert(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let buttonTitle = NSLocalizedString("AlertButtonTitle", comment: "")
        let OKAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func localizableGetString(forkey: String) -> String {
        let string = NSLocalizedString(forkey, comment: "")
        return string
    }
}
