//
//  SceneDelegate.swift
//  Utils
//
//  Created by 刘宏立 on 2020/12/19.
//

import UIKit
import URLNavigator
import CYLTabBarController

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var navigator: NavigatorType?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
//        let navigator = Navigator()
//        NavigationMap.initialize(navigator: navigator)
        
        
        
        
        
        
        
        let navigator = Navigator()
        let params = NavigationParams.user(navigator: navigator, param: ["name":"userlink"])
        NavigationEnum.initialize(navigator: navigator, params: params)
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = .white
//        let nav = UINavigationController.init(rootViewController: TabBarViewController()) //TabBarViewController
        
//        let nav = ESTabBarProvider.customIrregularityStyle(delegate: nil)
        
        let nav = ESTabBarProvider.lottieSytle()
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        
//        let userListViewController = UserListViewController(navigator: navigator)
//        window?.rootViewController = UINavigationController(rootViewController: userListViewController)
//        self.navigator = navigator
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


extension SceneDelegate {
    func viewControllers() -> [UINavigationController]{
        let home = UINavigationController(rootViewController: ListTableViewController())
        let connection = UINavigationController(rootViewController: ListTableViewController())
        let message = UINavigationController(rootViewController: ListTableViewController())
        let personal =   UINavigationController(rootViewController: ListTableViewController())
        let viewControllers = [home, connection, message, personal]
        
        return viewControllers
        
    }
    

    func tabBarItemsAttributesForController() ->  [[String : String]] {
        
        let tabBarItemOne = [CYLTabBarItemTitle:"首页",
                             CYLTabBarItemImage:"home_normal",
                             CYLTabBarItemSelectedImage:"home_highlight"]
        
        let tabBarItemTwo = [CYLTabBarItemTitle:"同城",
                             CYLTabBarItemImage:"mycity_normal",
                             CYLTabBarItemSelectedImage:"mycity_highlight"]
        
        let tabBarItemThree = [CYLTabBarItemTitle:"消息",
                               CYLTabBarItemImage:"message_normal",
                               CYLTabBarItemSelectedImage:"message_highlight"]
        
        let tabBarItemFour = [CYLTabBarItemTitle:"我的",
                              CYLTabBarItemImage:"account_normal",
                              CYLTabBarItemSelectedImage:"account_highlight"]
        let tabBarItemsAttributes = [tabBarItemOne,tabBarItemTwo,tabBarItemThree,tabBarItemFour]
        return tabBarItemsAttributes
    }
}

