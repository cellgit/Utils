//
//  UIView+Extension.swift
//  Utils
//
//  Created by liuhongli on 2021/5/22.
//

import Foundation
import UIKit

//extension UIView {}
/// 设置视图阴影,注意设置圆角时不能设置maskToBounds属性=true
extension Zjy where Base: UIView {
    /// 设置阴影
    public func shadow() {
        let color = UIColor.init(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        let offsetSize = CGSize(width: 0, height: 0)
        self.base.layer.shadowColor = color.cgColor
        self.base.layer.shadowOpacity = 1
        self.base.layer.shadowRadius = 4
        self.base.layer.shadowOffset = offsetSize
    }
}
