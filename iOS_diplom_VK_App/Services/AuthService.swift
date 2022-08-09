//
//  AuthService.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 07.08.2022.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: AnyObject {
    
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
    
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    static let shared = AuthService()
    
    // экземпляр SDK
    private let vkSdk: VKSdk
    
    override init() {
        // при создании объекта класса, инициализируем SDK через appID
        vkSdk = VKSdk.initialize(withAppId: API.appID)
        super.init()
        print("VKSdk.initialize")
        // регистрируем SDK
        vkSdk.register(self)
        // Делегат
        vkSdk.uiDelegate = self
    }
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String?  {
        VKSdk.accessToken().accessToken
    }
    
    func wakeUpSession() {

        let scope = API.scope
        
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            switch state {
       
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFail()
            }
        }
    }
    
    // Обязательные методы делегата
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
