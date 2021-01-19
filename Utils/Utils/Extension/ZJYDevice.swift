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

