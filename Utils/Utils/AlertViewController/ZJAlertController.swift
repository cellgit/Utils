//
//  ZJAlertController.swift
//  Utils
//
//  Created by 刘宏立 on 2021/5/26.
//

import UIKit

enum ZJAlertStyle {
    /// 底部弹出
    case bottomFade
}

class ZJAlertController: UIViewController {
    
    /// 弹出样式
    open var style: ZJAlertStyle?
    
    /// 背景透明度
    open var alpha: CGFloat = 0.3 {
        didSet {
            self.view.backgroundColor = UIColor.init(white: 0, alpha: alpha)
        }
    }
    
    private var contentViewHeight: CGFloat = 0
    /// 内容视图
    private var contentView: UIView?
    private let screenHeight = UIScreen.main.bounds.height
    private let screenWidth = UIScreen.main.bounds.width
    private let duration: TimeInterval = 0.25
    private lazy var button: UIButton = {
        let button = UIButton.init(type: .custom)
        return button
    }()
    
    open func addContentView(_ contentView: UIView) {
        self.contentView = contentView
        view.addSubview(contentView)
        contentViewHeight = contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        contentView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: contentViewHeight)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fadeInTransform()
    }
    
    convenience init(style: ZJAlertStyle = .bottomFade) {
        self.init()
        self.style = style
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(white: 0, alpha: alpha)
        initialUI()
    }
    
    func initialUI() {
        view.addSubview(button)
        button.frame = self.view.frame
        button.addTarget(self, action: #selector(dismissAction(sender:)), for: .touchUpInside)
    }
    
    @objc func dismissAction(sender: UIButton) {
        self.fadeOutTransform()
    }

}


/// bottomFade
extension ZJAlertController {
    func fadeInTransform() {
        UIView.animate(withDuration: self.duration, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
            self.contentView?.transform = CGAffineTransform(translationX: 0, y: -self.contentViewHeight)
            // 需要在动画完成进行设置圆角路径
            
        }, completion: nil)
    }

    func fadeOutTransform() {
        UIView.animate(withDuration: self.duration, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
            self.contentView?.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (true) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}
