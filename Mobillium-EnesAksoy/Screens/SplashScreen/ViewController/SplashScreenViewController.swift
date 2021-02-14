//
//  SplashScreenViewController.swift
//  Mobillium-EnesAksoy
//
//  Created by ENES AKSOY on 12.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    // MARK: - Constants
    
    private let errorKey = "MessageTitle1"
    private let storyboardName = "ListScreen"
    
    // MARK: - Properties
    
    private var viewModel: SplashScreenViewModel!

    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SplashScreenViewModel()
        self.viewModel.delegate = self
    }
}

// MARK: - Delegate Method

extension SplashScreenViewController: SplashScreenViewModelDelegate {
    func updateView(nowPlayingData: ResponseModel?, upComingData: ResponseModel?, errorText: String) {
        if !errorText.isEmpty {
            self.createAlert(message: errorText, title: self.localizableGetString(forkey: self.errorKey))
        }
        
        ObjectStore.shared.nowPlayingData = nowPlayingData
        ObjectStore.shared.upComingData = upComingData
        let storyBoard : UIStoryboard = UIStoryboard(name: self.storyboardName, bundle:nil)
        let nextViewController = storyBoard.instantiateInitialViewController() as! UINavigationController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
}
