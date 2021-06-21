//
//  MainTabBarViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/6/21.
//

import Foundation
import CYLTabBarController
import UIKit

//class MainTabBarViewController: CYLTabBarController {
//
//}

class MainTabBarController: CYLTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    
    
}

extension MainTabBarController{
    
    override func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.updateSelectionStatusIfNeeded(for: tabBarController, shouldSelect: viewController)
        return true
    }
    
}
