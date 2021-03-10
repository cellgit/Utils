//
//  NavigationEnum.swift
//  Utils
//
//  Created by liuhongli on 2021/3/10.
//

import Foundation
import URLNavigator




public enum NavigationParams {
    
    case user(navigator: NavigatorType, param: [String: Any])
    case repo(navigator: NavigatorType, param: [String: Any])
    
    
    var path: String {
        switch self {
        case .user:
            return "navigator://user/<name2>"
        case .repo:
            return "navigator://user/<name>"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .user(let navigator, let param):
            return UserViewController.init(navigator: navigator, json: param)
        case .repo(let navigator, let param):
            return UserViewController.init(navigator: navigator, json: param)
        }
    }
    
    
}






enum NavigationEnum {
    
    static func initialize(navigator: NavigatorType, params: NavigationParams) {
        
        navigator.register(params.path) { url, values, context in
            
            return params.viewController
      }
      
    }

    
}


