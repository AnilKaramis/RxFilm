//
//  TabBarController.swift
//  RxFilm
//
//  Created by AnılKaramış on 6.06.2024.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let discoverItem = DiscoverViewController()
        discoverItem.tabBarItem = UITabBarItem(title: "AAA", image:UIImage(named: "BBB") , selectedImage: UIImage(named: "CCC"))
        
        let chartItem = ChartViewController()
        discoverItem.tabBarItem = UITabBarItem(title: "aaa", image: UIImage(named: "bbb"), selectedImage: UIImage(named: "ccc"))
        
        self.viewControllers = [discoverItem, chartItem]
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true
    }
}
