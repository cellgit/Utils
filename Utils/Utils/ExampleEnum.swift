//
//  ExampleEnum.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import Foundation


enum ExampleEnum: Int,CaseIterable {
    case alert = 0
    case sheet = 1
    case linedLabel = 2
    case pickerView = 3
}


enum AlertStyle: Int,CaseIterable {
    case style0
}
