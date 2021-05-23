//
//  Zjy.swift
//  Utils
//
//  Created by liuhongli on 2021/5/22.
//

import Foundation

public struct Zjy<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

extension NSObject: ZjyProtocol {}

public protocol ZjyProtocol {}

extension ZjyProtocol {
    
    public var zjy: Zjy<Self> {
        
        return Zjy(self)
    }
    
    public static var zjy: Zjy<Self>.Type {
        return Zjy.self
    }
}
