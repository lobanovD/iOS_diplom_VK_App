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
        navigationController?.navigationBar.barTintColor = UIColor(named: "tabBarColor")
        tabBar.tintColor = UIColor(named: "tabBarTintColor")
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "tabBarColor")
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationItem.title = item.title
    }
  
    override func viewDidLoad() {
        // Контроллеры
        let feedVC = NewsFeedViewController()
        let profileVC = UserProfileViewController()
        let favouriteVC = FavouriteNewsViewController()
        
        // Настройки контроллеров
        feedVC.tabBarItem.title  = VCConstants.feedVCTitle
        feedVC.tabBarItem.image = VCConstants.feedVCIcon
        profileVC.tabBarItem.title  = VCConstants.profileVCTitle
        profileVC.tabBarItem.image = VCConstants.profileVCIcon
        favouriteVC.tabBarItem.title  = VCConstants.favouriteVCTitle
        favouriteVC.tabBarItem.image = VCConstants.favouriteVCIcon
        self.viewControllers = [feedVC, profileVC, favouriteVC]
        self.tabBar.backgroundColor = VCConstants.TBBackground
    }
}
