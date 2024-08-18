//
//  MainTabBar.swift
//  X
//
//  Created by Mabast on 2024-08-12.
//

import UIKit

class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let homeVC = UINavigationController(rootViewController: HomeVC())
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        let searchVC = UINavigationController(rootViewController: SearchVC())
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        let notificationsVC = UINavigationController(rootViewController: NotificationsVC())
        notificationsVC.tabBarItem.image = UIImage(systemName: "bell")
        let directMessagesVC = UINavigationController(rootViewController: DirectMessagesVC())
        directMessagesVC.tabBarItem.image = UIImage(systemName: "envelope")
        
        UITabBar.appearance().tintColor = .label
      
        setViewControllers([homeVC, searchVC, notificationsVC, directMessagesVC], animated: true)
    }

}

