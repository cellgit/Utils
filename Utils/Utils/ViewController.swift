//
//  ViewController.swift
//  Utils
//
//  Created by 刘宏立 on 2020/12/19.
//

import UIKit
import SnapKit

var poplist: [QueueObject] = []

class ViewController: UIViewController {
    
    var times: Int = 0
    
    lazy var popButton0: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("pop view0", for: .normal)
        btn.backgroundColor = .systemTeal
        btn.tag = 0
        return btn
    }()
    lazy var popButton1: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("pop view1", for: .normal)
        btn.backgroundColor = .systemTeal
        btn.tag = 1
        return btn
    }()
    lazy var popButton2: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("pop view2", for: .normal)
        btn.backgroundColor = .systemTeal
        btn.tag = 2
        return btn
    }()
    
    lazy var enqueueButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("Enqueue Sender", for: .normal)
        btn.backgroundColor = .systemTeal
        return btn
    }()

    lazy var dequeueButton: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("Dequeue Sender", for: .normal)
        btn.backgroundColor = .systemTeal
        return btn
    }()
    
    lazy var popQueue: PriorityQueue = {
        let queue = PriorityQueue.init()
        return queue
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
//        initialLinedLabel()
        
//        data()
        layout()
    }
    
    
}




extension ViewController {
    func layout() {
        view.addSubview(enqueueButton)
        view.addSubview(dequeueButton)
        
        enqueueButton.addTarget(self, action: #selector(enqueueAction(sender:)), for: .touchUpInside)
        dequeueButton.addTarget(self, action: #selector(dequeueAction(sender:)), for: .touchUpInside)
        
        enqueueButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-100)
            $0.width.equalTo(200)
            $0.height.equalTo(60)
        }
        dequeueButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(60)
        }
    }
}

extension ViewController {
    @objc func enqueueAction(sender: UIButton) {
        debugPrint("times ====== \(times)")
        switch times {
        case 0:
            poplist = popQueue.enqueue(object: QueueObject.init(priority: 50000, object: popButton1))
        case 1:
            poplist = popQueue.enqueue(object: QueueObject.init(priority: 30000, object: popButton2))
        case 2:
            poplist = popQueue.enqueue(object: QueueObject.init(priority: 20000, object: popButton0))
        default:
            break
        }
//        debugPrint("enqueue ====== \(poplist)")
        times = times + 1
    }
    @objc func dequeueAction(sender: UIButton) {
        let queue = popQueue.dequeue()
        debugPrint("queue?.priority ====== \(queue?.priority)")
//        debugPrint("enqueue ====== \(queue?.object)")
        if let obj = queue?.object as? UIButton {
            view.addSubview(obj)
            obj.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-100)
            }
        }
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
