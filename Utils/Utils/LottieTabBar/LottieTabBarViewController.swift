//
//  LottieTabBarViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/5/23.
//

import Foundation
import UIKit

import ESTabBarController_swift

public protocol LottieTabBarDelegate: class {

    func lottieTabBar(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController)

    func lottieTabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem, selectIndex: Int)
}

open class LottieTabBarViewController: UITabBarController {

    public weak var lottieDelegate: LottieTabBarDelegate?

    public var tabbars: [UIViewController] = [] {
        didSet {
            self.viewControllers = tabbars
        }
    }

    var lastSelectIndex: Int = 0

    override open var selectedIndex: Int {
        didSet {
            self.tabBar.withOutAnimationLottieImage(index: selectedIndex)
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        self.tabBar.backgroundColor = .white
        //tabbar_bg_footer_container
        tabBar.shadowImage = UIImage()
        
        
        var selectionImage = UIImage(named:"tabbar_bg_footer_container")
        let tabSize = CGSize(width: SCREEN_WIDTH, height: kTabBarHeight)
        UIGraphicsBeginImageContext(tabSize)
        selectionImage?.draw(in: CGRect(x: 0, y: 0, width: tabSize.width, height: tabSize.height))
        selectionImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        tabBar.backgroundImage = selectionImage//UIImage.init(named: "tabbar_bg_footer_container")//UIImage()
        
        
        tabBar.tintColor = UIColor.systemGreen //ThemeColor.main
        
        
        

        // Do any additional setup after loading the view.
    }

    public func addTabLottieView(jsons: [String], titles: [String]? = nil) {
        for index in 0..<tabbars.count {
            guard index < jsons.count else { return }
            self.tabBar.addLottieImage(index: index, lottieName: jsons[index])
            self.tabBar.addRedPointView(index: index)
            if let titles = titles, index < titles.count {
                self.tabBar.items?[index].title = titles[index]
                
                let totalW = UIScreen.main.bounds.size.width
                let singleW = totalW / CGFloat(self.tabBar.items?.count ?? 1)
                let y:CGFloat = 5.0
                let x2 = ceil(CGFloat(index) * singleW + (singleW - LOTAnimationViewWidth2) / 2.0)
                let frame = CGRect(x: x2, y: y-30, width: LOTAnimationViewWidth2, height: LOTAnimationViewHeight2)
                
            } else {
                self.tabBar.items?[index].title = ""
                self.tabBar.items?[index].titlePositionAdjustment = UIOffset(horizontal: 15.0, vertical: 0.0)
            }
        }
    }
}

extension LottieTabBarViewController: UITabBarControllerDelegate {

    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        lottieDelegate?.lottieTabBar(tabBarController, shouldSelect: viewController)
        return true
    }

    override open func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let items = self.tabBar.items, items.contains(item) {
            let array = items as NSArray
            let index = array.index(of: item)
            if index == lastSelectIndex {
                return
            } else {
                lastSelectIndex = index
                self.tabBar.animationLottieImage(index: index)
                
//                self.tabBar.withOutAnimationLottieImage(index: index)
            }
            lottieDelegate?.lottieTabBar(tabBar, didSelect: item, selectIndex: index)
        }
    }
}
