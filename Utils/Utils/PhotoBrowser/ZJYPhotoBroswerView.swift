//
//  ZJYPhotoBroswerView2.swift
//  Utils
//
//  Created by 刘宏立 on 2021/2/6.
//

import Foundation
import UIKit

class ZJYPhotoBroswerView: UIView {
    
    
    struct Layout {
        static let lastBtnWidth: CGFloat = 25
        static let lastBtnHeight: CGFloat = 50
        
        static let pageLabelHeight: CGFloat = 19
        static let pageLabelWidth: CGFloat = 60
        static let pageLabelBottomMargin: CGFloat = isFullScreen ? 20 + 34 : 20
        static let pageLabelLeftMargin: CGFloat = 20
    }
    
    
    let photos: [String]
    
    lazy var previousButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "home_arrow_left"), for: .normal)
        self.addSubview(button)
        button.backgroundColor = .systemTeal
        return button
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "home_arrow_right"), for: .normal)
        self.addSubview(button)
        button.backgroundColor = .systemTeal
        return button
    }()
    
    lazy var pageLabel: UILabelPadding = {
        let l = UILabelPadding.init()
        l.font = UIFont.systemFont(ofSize: 14)
        l.textAlignment = .center
        l.textColor = UIColor.white
        l.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        l.layer.cornerRadius = Layout.pageLabelHeight / 2
        l.layer.masksToBounds = true
        l.paddingLeft = Layout.pageLabelHeight / 2
        l.paddingRight = Layout.pageLabelHeight / 2
        l.setContentHuggingPriority(UILayoutPriority(rawValue: 800), for: .horizontal)
        l.text = "200/1000000"
        return l
    }()
    
    lazy var collectionView: ZJYPhotoCollectionView = {
        let v = ZJYPhotoCollectionView.init(photos: self.photos)
        return v
    }()
    
    var guideView: ZJYGuideMaskView!
    
    init(photos: [String]) {
        self.photos = photos
        super.init(frame: .zero)
        self.initialUI()
        self.setupGuideView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialUI() {
        self.addSubview(collectionView)
        self.addSubview(previousButton)
        self.addSubview(nextButton)
        self.addSubview(pageLabel)
        
        self.collectionView.didScrollToPage = { [weak self] (current, total) in
            guard let `self` = self else { return }
            self.pageLabel.text = "\(current+1)/\(total)"
        }
        
        previousButton.action { [weak self](sender) in
            self?.collectionView.changePageAction?(.previous)
        }
        nextButton.action { [weak self](sender) in
            self?.collectionView.changePageAction?(.next)
        }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        previousButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(collectionView)
            make.left.equalTo(self)
            make.width.equalTo(Layout.lastBtnWidth)
            make.height.equalTo(Layout.lastBtnHeight)
        }
        nextButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(collectionView)
            make.right.equalTo(self)
            make.width.equalTo(Layout.lastBtnWidth)
            make.height.equalTo(Layout.lastBtnHeight)
        }
        pageLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Layout.pageLabelLeftMargin)
            $0.bottom.equalToSuperview().offset(-Layout.pageLabelBottomMargin)
            $0.height.equalTo(Layout.pageLabelHeight)
        }
        
    }
    
}

extension ZJYPhotoBroswerView {
    func setupGuideView() {
        let images = ["hand_left_right", "hand_small_big"]
        let guideView: ZJYGuideMaskView = ZJYGuideMaskView.init(parentView: self, images: images, imageType: .local, isAutoPlay: true, interval: 2)
        self.addSubview(guideView)
        guideView.fillSuperview()
    }
}
