//
//  ZJYSize.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

/// iPad UI设计的标准尺寸
let HEIGHT_ST: CGFloat = 768

let WIDTH_ST: CGFloat = 1024

let MiniRect = CGRect(x: 0, y: 0, width: HEIGHT_ST, height: WIDTH_ST)

/**
 * 缩放比宽*标注宽 = 实际显示宽度
 * 缩放比高*标注高 = 实际显示高度
 **/
/// 缩放比宽
let scale_w: CGFloat = SCREEN_WIDTH/WIDTH_ST
/// 缩放比高
let scale_h: CGFloat = SCREEN_HEIGHT/HEIGHT_ST

/// 是否全面屏
var isFullScreen : Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
}

/// 是否全面屏iPad
var isFullPad : Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    if isPad == true && UIApplication.shared.windows[0].safeAreaInsets.bottom > 0 {
        return true
    }
    else {
        return false
    }
}

///是否全面屏手机
var is_iPhoneX : Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    if isPad == true {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
}

/// 导航栏高度
let kNavBarHeight: CGFloat = is_iPhoneX ? 88 : 64
let kTabBarHeight: CGFloat = is_iPhoneX ? 83 : 49

/// iPad 导航栏高度
let kNavBarHeightPad: CGFloat = UIApplication.shared.statusBarFrame.size.height + 50.0

struct ZJYPlayerSize {
    // 非全屏时宽高
    static var midWidth: CGFloat {
        if isPad == true { // iPad
            return UIScreen.main.bounds.size.width*2/3
        }
        else { // iPhone
            return UIScreen.main.bounds.size.width
        }
    }
    static var midHeight: CGFloat {
        return ZJYPlayerSize.midWidth*9/16
    }
}

