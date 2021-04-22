//
//  PlayerSize.swift
//  Utils
//
//  Created by liuhongli on 2021/3/19.
//

import Foundation
import UIKit

/// 播放器尺寸
enum SWPlayerSize {
    /// 小窗口
    case min
    /// 竖屏时大小
    case mid
    /// 横屏全尺寸大小
    case max
    /// 自定义宽高
    case custom(size: CGSize)
}

/// 设备类型
enum SWPlatform {
    case pad
    case phone
    case mac
}


enum SWLoadingStatus {
    /// 加载中
    case loading
    /// 播放中
    case playing
    /// 播放结束
    case end
    /// 播放出错
    case error
}


/// 视图层次类型(0. 播放层; 1. 控制层; 2. 数据渲染层; 3. 弹幕层; 4. 字幕层(隐式字幕))
enum SWViewType {
    /// player的容器视图,即播放层:承载一切
    case container
    /// 控制层
    case control
    /// 数据驱动层
    case data
    /// 弹幕层
    case barrage
    /// 字幕层
    case subtitles
}
