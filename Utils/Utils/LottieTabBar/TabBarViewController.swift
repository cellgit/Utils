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

        let firstVC = ListTableViewController()
        firstVC.view.backgroundColor = UIColor.orange

        let secondVC = ListTableViewController()//HomeworkViewController() JoinClassViewController()
//        JoinClassViewController()
//        HomeworkViewController(
        let thirdVC = ListTableViewController()
        let fouthVC = ListTableViewController()
        let fifthVC = ListTableViewController()

        self.tabbars = [firstVC, secondVC, thirdVC,fouthVC,fifthVC]
//        self.addTabLottieView(jsons: ["tab_message_animate", "tab_me_animate", "tab_search_animate"])
        self.addTabLottieView(jsons: ["icon_home@2x", "icon_work@2X", "icon_ai@2x","icon_book@2x", "icon_mine@2x"], titles: ["首页", "作业", "AI诊学", "点读", "我的"]) //tab_me_animate  ,icon_home@2x
        self.selectedIndex = 0

//        self.tabBar.setBadgeStatus(index: 1, isHidden: false)
//        self.tabBar.setBadgeStatus(index: 0, isHidden: false, count: 100)
//        self.tabBar.setBadgeStatus(index: 2, isHidden: false, count: 9)

        // Do any additional setup after loading the view.
    }

}

