//
//  PlayerSize.swift
//  Utils
//
//  Created by liuhongli on 2021/3/19.
//

import Foundation

/// 播放器尺寸
enum SWPlayerSize {
    /// 小窗口
    case min
    /// 竖屏时大小
    case mid
    /// 横屏全尺寸大小
    case max
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


/// 视图类型
enum SWViewType {
    /// player的容器视图,即播放层:承载一切
    case container
}
