//
//  TabBarController.swift
//  RxFilm
//
//  Created by AnılKaramış on 6.06.2024.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    let appearanceTabBar: UITabBarAppearance = {
        var apperance = UITabBarAppearance()
        apperance.configureWithOpaqueBackground()
        apperance.backgroundColor = UIColor(named: Colors.light_Background)
        return apperance
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .white
        self.tabBar.scrollEdgeAppearance = appearanceTabBar
        self.tabBar.standardAppearance = appearanceTabBar

        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let discoverItem = DiscoverViewController()
        discoverItem.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        
        let discoverNavigationItem = UINavigationController(rootViewController: discoverItem)
        
        let chartItem = ChartViewController()
        chartItem.tabBarItem = UITabBarItem(title: "Charts", image: UIImage(systemName: "list.number"), selectedImage: UIImage(systemName: "list.number"))
        
        let chartNavigationItem = UINavigationController(rootViewController: chartItem)
        
        let elseItem = CreditViewController()
        elseItem.tabBarItem = UITabBarItem(title: "Soon", image: UIImage(systemName: "ellipsis"), selectedImage: UIImage(systemName: "Credits"))
        
        self.viewControllers = [discoverNavigationItem, chartNavigationItem, elseItem]

    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}
