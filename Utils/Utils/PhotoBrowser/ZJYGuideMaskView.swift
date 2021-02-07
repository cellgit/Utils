//
//  ZJYGuideMaskView.swift
//  Utils
//
//  Created by liuhongli on 2021/2/7.
//

import UIKit

/// 图片地址类型
enum ImageResourceType {
    /// urlstring
    case url
    /// 本地的文件的
    case local
}

class ZJYGuideMaskView: UIView {
    
    public var changeStepAction: ((_ type: StepActionType) -> Void)?
    
    private let images: [String]
    private let parentView: UIView
    private let imageType: ImageResourceType
    
    private var currentIndex: Int = 0
    
    lazy var imageView: UIImageView = {
        let v = UIImageView.init()
        return v
    }()
    
    private let interval: TimeInterval
    
    var repeats: Bool = true
    
    var timer: Timer!
    /// 自动播放是否结束
    fileprivate var isPlayEnded: Bool = false
    
    init(parentView: UIView, images: [String], imageType: ImageResourceType = .local, isAutoPlay: Bool = false, interval: TimeInterval = 2) {
        self.parentView = parentView
        self.images = images
        self.imageType = imageType
        self.interval = interval
        super.init(frame: .zero)
        initial()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initial() {
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        imageView.isUserInteractionEnabled = true
        self.addSubview(imageView)
        self.changeImage(self.currentIndex)
        autoChangeImage()
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func changeImageAction(step: StepActionType) {
        let index = stepActionIndex(step)
        self.changeImage(index)
    }
    
    func changeImage(_ index: Int) {
        if index < images.count {
            imageView.image = UIImage.init(named: images[index])
        }
    }
    func stepActionIndex(_ step: StepActionType) -> Int {
        switch step {
        case .previous:
            currentIndex = currentIndex - 1
            return currentIndex
        default:
            currentIndex = currentIndex + 1
            return currentIndex
        }
    }
    
    func removeGuideViewAction() {
        if isPlayEnded == true {
            self.removeFromSuperview()
        }
        else {
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeGuideViewAction()
    }

}


extension ZJYGuideMaskView {
    private func autoChangeImage() {
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(start), userInfo: nil, repeats: repeats)
    }
    
    @objc private func start() {
        if self.currentIndex < self.images.count-1 {
            self.changeImageAction(step: .next)
        }
        else {
            stop()
        }
    }
    
    func stop() {
        timer.invalidate()
        timer = nil
        isPlayEnded = true
    }
}
