//
//  CustomSlider.swift
//  Utils
//
//  Created by 刘宏立 on 2021/1/11.
//

import Foundation
import UIKit

class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let height: CGFloat = 10
        let offset_y: CGFloat = (self.frame.height - height) / 2
        return CGRect(x: 0, y: offset_y, width: self.frame.width, height: height)
    }
}


