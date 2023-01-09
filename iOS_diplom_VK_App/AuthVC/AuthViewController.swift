//
//  AuthViewController.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 06.08.2022.
//

import UIKit

final class AuthViewController: UIViewController, VKAuthServiceDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        VKAuthService.shared.delegate = self
        VKAuthService.shared.wakeUpSession()
    }
    
    
    // MARK: AuthServiceDelegate
    func authServiceShouldShow(viewController: UIViewController) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func authServiceSignIn() {
        let tabBarVC = CustomTabBar()
        navigationController?.pushViewController(tabBarVC, animated: false)
        navigationController?.navigationBar.isHidden = false
    }
    
    func authServiceSignInDidFail() {
    }
}
