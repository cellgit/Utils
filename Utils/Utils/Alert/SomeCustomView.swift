//
//  SomeCustomView.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit

class SomeCustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .cyan
        
        let label = UILabel.init()
        addSubview(label)
        label.text = "3333"
        label.fillSuperview()
    }

}
