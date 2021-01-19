//
//  SheetEnum.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import Foundation
import UIKit

enum SheetStyle: Int,CaseIterable  {
    /// 底部取消
    case cancel
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
    /// 是否有分割线
    var isSeparator: Bool? = true
    /// 高度
    var height: CGFloat? = 44
}
