//
//  ProgressBarViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/6/2.
//

import UIKit

class ProgressBarViewController: UIViewController {
    
    
    lazy var contentView: OProgressView3 = {
        let view = OProgressView3.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = .systemTeal
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialUI()
        
        contentView.setProgress(80, animated: true, withDuration: 2)
    }
    

    func initialUI() {
        self.view.addSubview(contentView)
//        contentView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.width.height.equalTo(50)
//        }
    }

}
