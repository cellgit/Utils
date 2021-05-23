//
//  TabBarViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/5/23.
//

import Foundation
import UIKit

class TabBarViewController: LottieTabBarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstVC = UIViewController()
        firstVC.view.backgroundColor = UIColor.orange

        let secondVC = UIViewController()
        secondVC.view.backgroundColor = UIColor.yellow

        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = UIColor.blue
        let fouthVC = UIViewController()
        thirdVC.view.backgroundColor = UIColor.blue
        let fifthVC = UIViewController()
        thirdVC.view.backgroundColor = UIColor.blue

        self.tabbars = [firstVC, secondVC, thirdVC,fouthVC,fifthVC]
//        self.addTabLottieView(jsons: ["tab_message_animate", "tab_me_animate", "tab_search_animate"])
        self.addTabLottieView(jsons: ["tab_me_animate", "icon_work@2X", "icon_ai@2x","icon_book@2x", "icon_mine@2X"], titles: ["首页", "作业", "AI", "点读", "我的"]) //tab_me_animate  ,icon_home@2x
        self.selectedIndex = 0

//        self.tabBar.setBadgeStatus(index: 1, isHidden: false)
//        self.tabBar.setBadgeStatus(index: 0, isHidden: false, count: 100)
//        self.tabBar.setBadgeStatus(index: 2, isHidden: false, count: 9)

        // Do any additional setup after loading the view.
    }

}

