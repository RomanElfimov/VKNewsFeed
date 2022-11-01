//
//  ViewController.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 26.06.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var authService: AuthenticationService!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = SceneDelegate.shared().authService
    }
    
    // MARK: - Action
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        authService.wakeUpSession()
    }
    
}
