//
//  UINib+Extension.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit

extension UINib {
    
    fileprivate static func nib<T>(from classType: T.Type) -> UINib where T: UIView {
        return UINib(nibName: classType.identifier, bundle: nil)
    }
    
    static func instance<T>(_ classType: T.Type) -> UINib where T: UIView {
        return nib(from: classType)
    }
}

