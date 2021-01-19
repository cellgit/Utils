//
//  UIView+Identifier.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit

protocol Identifierable {
    static var identifier: String {get}
}
extension Identifierable {
    static var identifier: String {
        return String(describing: self.self)
    }
}

extension UIView: Identifierable {}
