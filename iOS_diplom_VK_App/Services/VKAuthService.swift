//
//  VKAuthService.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 07.08.2022.
//

import Foundation
import VKSdkFramework

protocol VKAuthServiceDelegate: AnyObject {
    
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
    
}

final class VKAuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    static let shared = VKAuthService()
    
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
    
    weak var delegate: VKAuthServiceDelegate?
    
    var token: String?  {
        VKSdk.accessToken().accessToken
    }
    
    func wakeUpSession() {
        
        // При смене ID приложения нужно разлогиниться на текущем устройстве, раскомментировав эту строку
//        VKSdk.forceLogout()
        
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
                VKSdk.authorize(scope)
            }
        }
    }
    
    // Обязательные методы делегата
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    }
}
