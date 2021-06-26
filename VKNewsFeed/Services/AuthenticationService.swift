//
//  AuthenticationService.swift
//  VKNewsFeed
//
//  Created by Роман Елфимов on 26.06.2021.
//

import Foundation
import VK_ios_sdk

class AuthenticationService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    // id приложения
    private let appId = "7889204"
    private var vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        
        print("VKSdk initialize")
        
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    
    // MARK: - VKSdkDelegate, VKSdkUIDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
