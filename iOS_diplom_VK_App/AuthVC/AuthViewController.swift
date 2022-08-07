//
//  AuthViewController.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 06.08.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    
    @IBAction func signInTouch(_ sender: UIButton) {
//        authService.wakeUpSession()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .red
        
        authService = SceneDelegate.shared().authService
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        authService.wakeUpSession()
    }


}

