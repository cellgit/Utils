//
//  UIButton+ClosureButton.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit

var ClosureButtonKey = "ClosureButtonKey"

typealias btnCallBack = ()->()

extension UIButton {
    @objc open func action(_ closure: @escaping ((_ self: UIButton) -> ())) {
        
        self.addTarget(self, action: #selector(evt_btn_action(sender:)), for: .touchUpInside)
        self.buttonClosure = closure
    }
    @objc private func evt_btn_action(sender: UIButton) {
        guard let call = buttonClosure else { return }
        call(sender)
    }
    private var buttonClosure: ((_ sender: UIButton) -> Void)? {
        set {
            objc_setAssociatedObject(self, &ClosureButtonKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &ClosureButtonKey) as? ((_ sender: UIButton) -> Void)
        }
    }
}

