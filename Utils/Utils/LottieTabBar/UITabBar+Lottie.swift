//
//  UITabBar+Lottie.swift
//  Utils
//
//  Created by liuhongli on 2021/5/23.
//

import Foundation
import UIKit
import Lottie

let LOTAnimationViewWidth: CGFloat = 25//35.0
let LOTAnimationViewHeight: CGFloat = 25//35.0

let LOTAnimationViewWidth2: CGFloat = 50//35.0
let LOTAnimationViewHeight2: CGFloat = 50//35.0



let RedPointViewWidthAndHeight: CGFloat = 8.0
let RedPointLabelWidthAndHeight: CGFloat = 16.0


var kCenterTabBarView: UIView?


extension UITabBar {

    static var lastTag: Int = 0

    // json动画
    func addLottieImage(index: Int, lottieName: String) {
        if Thread.isMainThread {
            self.addLottieImageInMainThread(index: index, lottieName: lottieName)
        } else {
            DispatchQueue.main.async {
                self.addLottieImageInMainThread(index: index, lottieName: lottieName)
            }
        }
    }

    // 红点
    func addRedPointView(index: Int) {
        if Thread.isMainThread {
            self.addRedPointViewInMainThread(index: index)
        } else {
            DispatchQueue.main.async {
                self.addRedPointViewInMainThread(index: index)
            }
        }
    }
    
    

    private func addLottieImageInMainThread(index: Int, lottieName: String) {
        let lottieView = LOTAnimationView(name: lottieName)
        let totalW = UIScreen.main.bounds.size.width
        let singleW = totalW / CGFloat(self.items?.count ?? 1)
        let y:CGFloat = 5.0
        
        if index == 2 {
            let x2 = ceil(CGFloat(index) * singleW + (singleW - LOTAnimationViewWidth2) / 2.0)
            lottieView.frame = CGRect(x: x2, y: y-30, width: LOTAnimationViewWidth2, height: LOTAnimationViewHeight2)
            lottieView.zjy.shadow()
            
            kCenterTabBarView = lottieView
        }
        else {
            let x = ceil(CGFloat(index) * singleW + (singleW - LOTAnimationViewWidth) / 2.0)
            lottieView.frame = CGRect(x: x, y: y, width: LOTAnimationViewWidth, height: LOTAnimationViewHeight)
        }
        
        
        lottieView.isUserInteractionEnabled = false
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopAnimation = false
        lottieView.tag = 1000 + index;
        self.addSubview(lottieView)
    }
    
    
    

    private func addRedPointViewInMainThread(index: Int) {
        let redView = UIView()
        let totalW = UIScreen.main.bounds.size.width
        let singleW = totalW / CGFloat(self.items?.count ?? 1)
        let x = ceil(CGFloat(index) * singleW + singleW / 2.0 + LOTAnimationViewWidth / 2.0 - 5.0)
        let y:CGFloat = 5.0
        redView.frame = CGRect(x: x, y: y, width: RedPointViewWidthAndHeight, height: RedPointViewWidthAndHeight)
        redView.backgroundColor = UIColor.red
        redView.layer.cornerRadius = RedPointViewWidthAndHeight / 2.0
        redView.tag = 2000 + index;
        redView.isHidden = true
        self.addSubview(redView)
    }

    // 设置红点状态
    public func setBadgeStatus(index: Int, isHidden: Bool, count: Int = 0) {
        let redView = self.viewWithTag(2000 + index)
        if isHidden {
            redView?.isHidden = true
            self.items?[index].badgeValue = nil
        } else {
            if count > 0 {
                let badgeText = count <= 99 ? "\(count)" : "\(99)+"
                redView?.isHidden = true
                self.items?[index].badgeValue = isHidden == false ? badgeText : nil
            } else {
                redView?.isHidden = false
                self.items?[index].badgeValue = nil
            }
        }
    }

    // 点击动画
    func animationLottieImage(index: Int) {
        stopAnimationAllLottieView()
        if let lottieView = self.viewWithTag(1000 + index) as? LOTAnimationView {
            lottieView.animationProgress = 0.0
            lottieView.play { _ in
                UITabBar.lastTag = 1000 + index
            }
        }
    }

    // 无动画选中
    func withOutAnimationLottieImage(index: Int) {
        guard let items = items, index < items.count else { return }
        stopAnimationAllLottieView()
        if let lottieView = self.viewWithTag(1000 + index) as? LOTAnimationView {
            lottieView.animationProgress = 1.0
        }
    }

    // 停止其他动画
    func stopAnimationAllLottieView() {
        guard let items = self.items else { return }
        var i = 0
        for _ in items {
            if let lottieView = self.viewWithTag(1000 + i) as? LOTAnimationView {
                if UITabBar.lastTag == 1000 + i {
                    // 这个会同时动画上一次选中的
//                    lottieView.play(fromProgress: 1.0, toProgress: 0.0) { _ in
//                        lottieView.stop()
//                    }
                    
                    lottieView.stop()
                } else {
                    lottieView.stop()
                }
            }
            i += 1
        }
    }
    
//    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//
//        if self.isHidden {
//            return super.hitTest(point, with: event)
//        }
//        else {
//            if let tempPoint = kCenterTabBarView?.convert(point, to: self),
//               kCenterTabBarView?.bounds.contains(tempPoint) == true {
//                return kCenterTabBarView
//
//            }
//            else {
//                return super.hitTest(point, with: event)
//            }
//        }
//    }
    
    
}


extension LOTAnimationView {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        else {
            if let tempPoint = kCenterTabBarView?.convert(point, to: self),
               kCenterTabBarView?.bounds.contains(tempPoint) == true {
                return kCenterTabBarView
                
            }
            else {
                return super.hitTest(point, with: event)
            }
        }
    }
}


//        if (self.hidden){ //如果tabbar隐藏了，那么直接执行系统方法
//            return [super hitTest:point withEvent:event];
//        }else {
//            //转换坐标
//            CGPoint tempPoint = [self.centerBtn convertPoint:point fromView:self];
//            //判断点击的点是否在按钮区域内
//            if (CGRectContainsPoint(self.centerBtn.bounds, tempPoint)){
//                //返回按钮
//                return _centerBtn;
//            }else {
//                return [super hitTest:point withEvent:event];
//            }
//        }
