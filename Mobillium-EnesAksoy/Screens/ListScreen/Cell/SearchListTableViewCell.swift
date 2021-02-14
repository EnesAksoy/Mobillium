//
//  SearchListTableViewCell.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 13.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Cell Configuration Method
    
    func cellConfiguration(title: String?) {
        self.titleLabel.text = title
    }
}
