//
//  ESTabBarProvider.swift
//  Utils
//
//  Created by liuhongli on 2021/6/23.
//

import Foundation
import ESTabBarController_swift


enum ESTabBarProvider {
    
    static func systemStyle() -> UITabBarController {
        let tabBarController = UITabBarController()
        let v1 = ListTableViewController()
        let v2 = ListTableViewController()
        let v3 = ListTableViewController()
        
        //tabbar_background_img
        
        v1.tabBarItem = UITabBarItem.init(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        tabBarController.tabBar.shadowImage = nil
        tabBarController.viewControllers = [v1,v2,v3]
        return tabBarController
    }
    
    static func customStyle() -> UINavigationController { //ESTabBarController
        
        let tabBarController = ESTabBarController()
        /// 设置TabBar背景色和背景图像
        tabBarController.tabBar.backgroundColor = UIColor.init(white: 0, alpha: 0)
        tabBarController.tabBar.shadowImage = UIImage()
        let image = UIImage(named:"tabbar_background_img")
//        let image = UIImage(named:"homework_progress_point")
        
        
        var selectionImage = image?.resizableImage(withCapInsets: UIEdgeInsets(top: 45, left: 0, bottom: 1, right: 0), resizingMode: .stretch)
        let tabSize = CGSize(width: SCREEN_WIDTH, height: kTabBarHeight)
        UIGraphicsBeginImageContext(tabSize)
        selectionImage?.draw(in: CGRect(x: 0, y: 0, width: tabSize.width, height: tabSize.height))
        selectionImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tabBarController.tabBar.backgroundImage = selectionImage
        
        tabBarController.tabBar.backgroundColor = .orange
        
        let v1 = ListTableViewController()
        let v2 = ListTableViewController()
        let v3 = ListTableViewController()
        
        v1.tabBarItem = ESTabBarItem.init(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem.init(title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem.init(title: "Photo", image: UIImage(named: "photo"), selectedImage: UIImage(named: "photo_1"))
        
        tabBarController.viewControllers = [v1, v2, v3]
        
        let navigationController = UINavigationController.init(rootViewController: tabBarController)
        return navigationController
        
//        tabBarController.viewControllers = [v1, v2, v3]
//        return tabBarController
    }
    
    
    
    
    

    static func lottieSytle() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        
        /// 设置TabBar背景色和背景图像
        tabBarController.tabBar.backgroundColor = UIColor.init(white: 0, alpha: 0)
        tabBarController.tabBar.shadowImage = UIImage()
        let image = UIImage(named:"tabbar_background_icon")
//        let image = UIImage(named:"homework_progress_point")
        
        
        var selectionImage = image?.resizableImage(withCapInsets: UIEdgeInsets(top: 45, left: 0, bottom: 2, right: 0), resizingMode: .stretch)
//        let tabSize = CGSize(width: SCREEN_WIDTH, height: kTabBarHeight)
        
        let tabSize = CGSize(width: SCREEN_WIDTH, height: 200)
        UIGraphicsBeginImageContext(tabSize)
        selectionImage?.draw(in: CGRect(x: 0, y: -10, width: tabSize.width, height: tabSize.height))
        selectionImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tabBarController.tabBar.backgroundImage = selectionImage
        tabBarController.tabBar.backgroundColor = UIColor.init(white: 0, alpha: 0)
//        tabBarController.tabBar.backgroundColor = .orange
        
        
        
        let v1 = ListTableViewController()
        let v2 = ListTableViewController()
        let v3 = ListTableViewController()
        let v4 = ListTableViewController()
        let v5 = ListTableViewController()
        
        v1.tabBarItem = ESTabBarItem.init(ExampleLottieAnimateContentView.init(index: 0), title: "首页", image: nil, selectedImage: nil)
        v2.tabBarItem = ESTabBarItem.init(ExampleLottieAnimateContentView.init(index: 1), title: "第二页", image: nil, selectedImage: nil)
        v3.tabBarItem = ESTabBarItem.init(ExampleLottieAnimateContentView.init(index: 2), title: "AI诊学", image: nil, selectedImage: nil)
        v4.tabBarItem = ESTabBarItem.init(ExampleLottieAnimateContentView.init(index: 3), title: "第四页", image: nil, selectedImage: nil)
        v5.tabBarItem = ESTabBarItem.init(ExampleLottieAnimateContentView.init(index: 4), title: "第五页", image: nil, selectedImage: nil)
        
        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
        
        return tabBarController
    }

    
    
    
}


