//
//  SWPlayerControlView.swift
//  Utils
//
//  Created by liuhongli on 2021/3/22.
//

import UIKit
import SnapKit

class SWPlayerControlView: UIView {
    
    let parentView: UIView
    
    
    init(_ view: UIView) {
        parentView = view
        
        super.init(frame: .zero)
        
        initial()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initial() {
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
//        parentView.addSubview(self)
//
//
//        self.snp.makeConstraints {
//            $0.width.height.equalToSuperview()
//            $0.left.top.equalToSuperview()
//        }
    }
    
}
