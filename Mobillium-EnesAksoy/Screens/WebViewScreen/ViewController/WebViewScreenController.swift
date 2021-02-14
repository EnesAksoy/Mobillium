//
//  WebViewScreenController.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit
import WebKit

class WebViewScreenController: UIViewController {

    // MARK: - Proporties
    
    private let imdbBaseUrl = "https://www.imdb.com/title/"
    
    // MARK: - Outlets
    
    @IBOutlet weak var webview: WKWebView!
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callWebsite()
    }

    // MARK: - Functions
    
    private func callWebsite() {
        let imdbUrl = URL(string: "\(imdbBaseUrl)\(ObjectStore.shared.imdbId ?? "")")
        let request = URLRequest(url: imdbUrl!)
        webview.load(request)
    }
}
