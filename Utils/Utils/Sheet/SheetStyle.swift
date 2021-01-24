//
//  SheetEnum.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import Foundation
import UIKit

/// 动画速度
let kVelocity: CGFloat = 1000

enum SheetStyle: Int,CaseIterable  {
    /// 底部取消
    case cancel
}


/// 自定义Sheet初始化设置
struct SheetConfigure {
    /// sheet弹框的样式
    public var style: SheetStyle = .cancel
    /// 列表最多显示几行
    public var maxRow: Int = 4
    
    /// 列表和底部按钮容器的间距
    public var padding: CGFloat = 0
    /// 按钮容器与按钮底部或顶部的间距
    public var margin: CGFloat = 0
    /// 底部按钮的高度
    public var buttonHeight: CGFloat = 44
    /// contentView顶部圆角
    public var cornerRadius: CGFloat = 8
    /// 底部按钮的标题
    public var buttonTitle: String? = "取消"
    /// 底部按钮的标题颜色
    public var buttonTitleColor: UIColor? = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
    /// 底部按钮的标题字号大小
    public var buttonTitleFont: UIFont? = UIFont.systemFont(ofSize: 14)
    /// 底部按钮左边间距
    public var buttonLeftMargin: CGFloat = 0
    /// 底部按钮右边间距
    public var buttonRightMargin: CGFloat = 0
    /// 底部按钮圆角大小
    var buttonCornerRadius: CGFloat = 0
    /// 底部按钮的背景色
    var buttonBackgroundColor: UIColor = .white
    
    /// 底部按钮容器和safeView颜色
    var bottomBackgroundColor: UIColor = .white
    
    /// 内容视图的背景色
    var contentViewBackgroundColor: UIColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
    
    /// 动画时间(弹框弹出世间)
    public var duration: TimeInterval = TimeInterval(200 / kVelocity)
}


struct SheetCellModel {
    /// 标识
    var identifier: String?
    /// 标题
    var title: String?
    /// 字号
    var font: UIFont? = UIFont.systemFont(ofSize: 14)
    /// 标题颜色
    var titleColor: UIColor? = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
    /// 是否显示分割线
    var isHiddenSeparator: Bool? = true
    /// 高度
    var height: CGFloat? = 44
}
