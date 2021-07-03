//
//  ExampleLottieAnimateContentView.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 2017/2/11.
//  Copyright © 2018年 Egg Swift. All rights reserved.
//

import UIKit
import Lottie
import ESTabBarController_swift

class ExampleLottieAnimateBasicContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(red: 61/255.0, green: 206/255.0, blue: 193/255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 252/255.0, green: 13/255.0, blue: 27/255.0, alpha: 1.0)
        iconColor = UIColor.init(red: 61/255.0, green: 206/255.0, blue: 193/255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(red: 252/255.0, green: 13/255.0, blue: 27/255.0, alpha: 1.0)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




class ExampleLottieAnimateContentView: ExampleLottieAnimateBasicContentView {

    let iconList: [String] = ["icon_home@2x", "icon_work@2X", "icon_ai@2x", "icon_book@2x", "icon_mine@2x"]
    
//    let lottieView: LOTAnimationView! = {
//        let lottieView = LOTAnimationView.init(name: "icon_ai@2x")
//        lottieView.loopAnimation = false
//        lottieView.contentMode = .scaleAspectFill
//        lottieView.pause()
//        return lottieView
//    }()
    
    
//    lazy var lottieView: LOTAnimationView = {
//        return getLottieView(index: index)
//    }()
    
    var lottieView: LOTAnimationView!
    
    
    func getLottieView(index: Int) -> LOTAnimationView {
        let lottieView = LOTAnimationView.init(name: iconList[index])
        lottieView.loopAnimation = false
        lottieView.contentMode = .scaleAspectFill
        lottieView.stop()
        return lottieView
    }
    
    
    let index: Int
    
    init(index: Int) {
        self.index = index
        super.init(frame: .zero)
        
        self.lottieView = getLottieView(index: index)
        
        self.addSubview(lottieView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    struct Layout {
        static let centerOffsetX: CGFloat = is_iPhoneX ? -0.5 : 0.5
        
        static let topOffsetX: CGFloat = is_iPhoneX ? -32 : -30
        
    }
    
    override func updateLayout() {
        super.updateLayout()
        if self.index == 2 {
            self.lottieView.snp.makeConstraints {
                $0.centerX.equalToSuperview().offset(Layout.centerOffsetX)
                $0.top.equalToSuperview().offset(Layout.topOffsetX)
//                $0.width.height.equalTo(65)
                $0.width.equalTo(55)
                $0.height.equalTo(55)
            }
            self.titleLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(lottieView.snp.bottom).offset(is_iPhoneX ? 14 : 9)
            }
            
        }
        else {
            self.lottieView.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().offset(is_iPhoneX ? 5 : 0)
                $0.width.height.equalTo(25)
            }
            self.titleLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(lottieView.snp.bottom).offset(7)
            }
            
            
            
        }

    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        super.selectAnimation(animated: animated, completion: nil)
        lottieView.play()
    }
    
    override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
        super.deselectAnimation(animated: animated, completion: nil)
        lottieView.stop()
    }
    
    
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint.init(x: point.x - lottieView.frame.origin.x, y: point.y - lottieView.frame.origin.y)
        return sqrt(pow(lottieView.bounds.size.width / 2.0 - p.x, 2) + pow(lottieView.bounds.size.height / 2.0 - p.y, 2)) < lottieView.bounds.size.width / 2.0
    }

}



