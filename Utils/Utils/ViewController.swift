//
//  ViewController.swift
//  Utils
//
//  Created by 刘宏立 on 2020/12/19.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        initialLinedLabel()
    }


}


extension ViewController {
    func initialLinedLabel() {
        let linedLabel: LinedLabel = LinedLabel.init(lineColor: UIColor.red.cgColor, lineWidth: 1)
        view.addSubview(linedLabel)
        linedLabel.text = "原价: $100"
        linedLabel.font = UIFont.systemFont(ofSize: 10)
        linedLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
}
