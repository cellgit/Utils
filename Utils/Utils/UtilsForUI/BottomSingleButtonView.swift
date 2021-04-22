//
//  BottomSingleButtonView.swift
//  Utils
//
//  Created by liuhongli on 2021/4/22.
//

import UIKit

class BottomSingleButtonView: UIView {
    
    
    private let title: String
    
    private let font: UIFont
    
    private let titleColor: UIColor
    
    private let buttonBackgroundColor: UIColor
    
    private let cornerRadius: CGFloat
    
    private let borderWidth: CGFloat
    
    private let borderColor: UIColor
    
    
    lazy var button: UIButton = {
        let button = UIButton.init(type: .custom)
        
        button.setTitle(self.title, for: .normal)
        button.setTitleColor(self.titleColor, for: .normal)
        button.backgroundColor = buttonBackgroundColor
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor.cgColor
        button.titleLabel?.font = font
        return button
    }()
    

    init(title: String,
         font: UIFont = UIFont.systemFont(ofSize: 15),
         titleColor: UIColor = UIColor(red: 0.073, green: 0.733, blue: 0.456, alpha: 1),
         buttonBackgroundColor: UIColor = .white,
         cornerRadius: CGFloat = 2,
         borderWidth: CGFloat = 0.5,
         borderColor: UIColor = UIColor(red: 0.073, green: 0.733, blue: 0.456, alpha: 1)
         ) {
        
        self.title = title
        self.font = font
        self.titleColor = titleColor
        self.buttonBackgroundColor = buttonBackgroundColor
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        
        super.init(frame: .zero)
        
        
        initialUI()
        
        
    }
    
    func initialUI() {
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.top.equalToSuperview().offset(-26)
            $0.height.equalTo(88)
        }
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
