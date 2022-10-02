//
//  CustomTabBar.swift
//  iOS_diplom_VK_App
//
//  Created by Dmitrii Lobanov on 28.09.2022.
//

import UIKit

final class CustomTabBar: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.tabBar.selectedItem?.title
        self.navigationItem.hidesBackButton = true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title
    }
    
    override func viewDidLoad() {
        // Контроллеры
        let feedVC = NewsFeedViewController()
        let profileVC = UserProfileViewController()
        // Настройки контроллеров
        feedVC.tabBarItem.title  = CustomTabBarConstants.feedVCTitle
        feedVC.tabBarItem.image = CustomTabBarConstants.feedVCIcon
        profileVC.tabBarItem.title  = CustomTabBarConstants.profileVCTitle
        profileVC.tabBarItem.image = CustomTabBarConstants.profileVCIcon
        self.viewControllers = [feedVC, profileVC]
        self.tabBar.backgroundColor = CustomTabBarConstants.TBBackground
    }
}
