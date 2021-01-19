//
//  AlphaButton.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit

class AlphaButton: UIButton {
    
    /// dismiss
    open var dismiss:(()-> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 1, alpha: 0.3)
        
        initial()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initial() {
        self.action { [weak self] (sender) in
            guard let `self` = self else {return}
            self.dismiss?()
        }
    }
    
}
