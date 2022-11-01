//
//  AuthenticationService.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 26.06.2021.
//

import Foundation
import VK_ios_sdk

// MARK: - Protocol AuthService Delegate
// Делегат нужен для того, чтобы можно было использовать функционал VKSdkDelegate вне данного класса. (Реализация в SceneDelegate)
protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}

class AuthenticationService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    // MARK: - Private Properties
    // id приложения
    private let appId = "7889204"
    private var vkSdk: VKSdk
    
    // MARK: - Initilizer
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        
        print("VKSdk initialize")
        
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    // MARK: - Method
    func wakeUpSession() {
        
        // Права доступа - что будем получать по API
        let scope = ["offline", "photos", "wall", "friends"]
        VKSdk.wakeUpSession(scope) { [delegate] state, _ in
            switch state {
            case .initialized:
                VKSdk.authorize(scope)
            case .authorized:
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFail()
            }
        }
    }
    
    // MARK: - Delegate
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken().accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken().userId
    }
    
    // MARK: - VKSdkDelegate, VKSdkUIDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
