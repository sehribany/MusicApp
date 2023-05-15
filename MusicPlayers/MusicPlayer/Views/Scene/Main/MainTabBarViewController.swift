//
//  MainTabBarViewController.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 8.05.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
        

    }
    
    // Initialize
    
    func initialize(){
        self.tabBarButton()
    }

    func tabBarButton(){
        
        // Created TabBarButton
        let vc1 = UINavigationController(rootViewController: CategoryViewController())
        let vc2 = UINavigationController(rootViewController: FavoritesViewController())
       
        
        
        // Created TabBarButton Icon
        
        vc1.tabBarItem.image = UIImage(systemName: "music.quarternote.3")
        vc2.tabBarItem.image = UIImage(systemName: "heart.circle")
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2], animated: true)
    }

}

