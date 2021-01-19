//
//  AlertStyleZeroViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit
import SwiftEntryKit

class AlertStyleZeroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        

    }
    

}



extension UIScreen {
    var minEdge: CGFloat {
        return UIScreen.main.bounds.minEdge
    }
}

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
