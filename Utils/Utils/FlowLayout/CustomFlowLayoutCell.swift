//
//  CustomFlowLayoutCell.swift
//  Utils
//
//  Created by 刘宏立 on 2021/6/15.
//

import UIKit

class CustomFlowLayoutCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialUI() {
        self.contentView.addSubview(titleLabel)
        titleLabel.fillSuperview()
    }
    
}
