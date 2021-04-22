//
//  SWPlayerProtocol.swift
//  Utils
//
//  Created by liuhongli on 2021/3/22.
//

import Foundation
import UIKit



class SWPlayerContainer<V: UIView> {
    
    let shared = SWPlayerContainer.init()
    
    
    func playerControlView(_ type: V.Type) -> V {
        
        return type.init()
    }
    
}




public protocol SWPlayerContainerProtocol: class {
    
    associatedtype ControlView: UIView
    // 控制层视图
    var controlView: ControlView? {get}
    
}

public extension SWPlayerContainerProtocol {
    
    func controlView() -> ControlView? {
        
        return controlView ?? nil
    }
    
}




protocol SWPlayerRotateProtocol {
    func rightRotate()
    func leftRotate()
}


protocol SWPlayerFullScreenProtocol: SWPlayerRotateProtocol {
    func fullScreen()
}





