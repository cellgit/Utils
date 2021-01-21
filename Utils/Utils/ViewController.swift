//
//  ViewController.swift
//  Utils
//
//  Created by 刘宏立 on 2020/12/19.
//

import UIKit
import SnapKit
import PagingViewKit

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
        view.backgroundColor = .white
        
//        initialLinedLabel()
        
//        data()
//        layout()
        
        initialSlider()
        
        initialPageTitle()
    }
    
    
}


extension ViewController: PagingTitleViewDelegate {
    func initialPageTitle() {
        let titles = ["全部", "一年级", "二年级", "三年级", "四年级", "五年级", "六年级", "七年级", "八年级", "九年级", "高一", "高二", "高三"]
        let titleView = PCoverTitleView.init(titles: titles)
        view.addSubview(titleView)
        
        titleView.snp.makeConstraints {
            $0.left.equalTo(self.view).offset(20)
            $0.right.equalTo(self.view).offset(-20)
            $0.height.equalTo(44)
            $0.top.equalToSuperview().offset(200)
        }
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


extension ViewController {
    func initialSlider() {
        
        let slider = CustomSlider.init()
        self.view.addSubview(slider)
        slider.setThumbImage(UIImage.init(named: "audio_slider_dot"), for: .normal)
        slider.backgroundColor = UIColor.orange
        slider.minimumTrackTintColor = .magenta
//        slider.transform =  CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        slider.snp.makeConstraints {
            $0.left.equalTo(self.view.snp.left).offset(100)
            $0.right.equalTo(self.view.snp.right).offset(-100)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(20)
        }
        
    }
}
