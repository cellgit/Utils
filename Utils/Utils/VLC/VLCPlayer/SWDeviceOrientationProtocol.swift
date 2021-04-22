//
//  SWDeviceOrientationProtocol.swift
//  Utils
//
//  Created by liuhongli on 2021/3/22.
//

import Foundation
import UIKit

//SWDeviceOrientationProtocol


//protocol SWDeviceOrientationProtocol {
//
//}


class SWDeviceOrientation {
    
    let shared = SWDeviceOrientation()
    
    /// 设备方向
    var orientation: UIDeviceOrientation = .unknown
    
    
    /// 监听屏幕方向
    static func observerDeviceOrientation() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }
    
    
    @objc func didChanged() -> Bool {
        let device = UIDevice.current
        switch device.orientation {
        case UIDeviceOrientation.faceUp:
            debugPrint("屏幕朝上平躺")
        case UIDeviceOrientation.faceDown:
            debugPrint("屏幕朝下平躺")
        case UIDeviceOrientation.unknown:
            debugPrint("未知方向")
        case UIDeviceOrientation.landscapeLeft:
            debugPrint("屏幕向左横置")
            
        case UIDeviceOrientation.landscapeRight:
            debugPrint("屏幕向右横置")
            
        case UIDeviceOrientation.portrait:
            debugPrint("屏幕直立")
            
        case UIDeviceOrientation.portraitUpsideDown:
            debugPrint("屏幕直立,上下颠倒")
        default:
            debugPrint("无法识别")
            break
        }
        return true
    }
    
}
