//
//  UITableView+Extension.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import Foundation
import UIKit

extension UITableView {
    
    func register<T>(_ classType: T.Type) where T: UITableViewCell  {
        register(classType, forCellReuseIdentifier: classType.identifier)
    }
    
    func dequeueReusableCell<T>(_ classType: T.Type, _ indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: classType.identifier, for: indexPath) as! T
    }
    
    func registerNib<T>(_ classType: T.Type) where T: UITableViewCell {
        register(UINib.instance(classType), forCellReuseIdentifier: classType.identifier)
    }
}

