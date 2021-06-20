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
    case photoBroswer = 4
    case vlcPlayer = 5
    case programma = 6
    case webView = 7
    
    case alertController = 8
    
    case progress = 9
    
}


enum AlertStyle: Int,CaseIterable {
    case style0
}
