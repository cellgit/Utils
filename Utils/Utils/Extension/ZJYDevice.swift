//
//  ZJYDevice.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

/**
 * 设备管理
 */

import UIKit

/// 判断是否iPad
let isPad = UIDevice.current.userInterfaceIdiom == .pad ? true : false

/// 屏幕方向
let kOrientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation

let kAppDelegate = UIApplication.shared.delegate

/////是否全面屏手机
//var is_iPhoneX : Bool {
//    guard #available(iOS 11.0, *) else {
//        return false
//    }
//    if isPad == true {
//        return false
//    }
//    return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
//}
