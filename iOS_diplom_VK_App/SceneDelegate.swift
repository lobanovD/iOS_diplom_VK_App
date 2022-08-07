//
//  SceneDelegate.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 06.08.2022.
//

import UIKit
import VKSdkFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AuthServiceDelegate {

    var window: UIWindow?
    
    var authService: AuthService!
    
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        let sd: SceneDelegate = (((scene?.delegate as? SceneDelegate)!))
        return sd
    }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        authService = AuthService()
        authService.delegate = self
        let authVC = AuthViewController()
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }


    // MARK: AuthServiceDelegate
    
    func authServiceShouldShow(viewController: UIViewController) {
        print(#function)
        window?.rootViewController = viewController
    }
    
    func authServiceSignIn() {
        print(#function)
        let feedVC = UIStoryboard(name: "FeedViewController", bundle: nil).instantiateInitialViewController() as! FeedViewController
        let navigationVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navigationVC
    }
    
    func authServiceSignInDidFail() {
        print(#function)
    }

}

