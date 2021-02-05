//
//  ZJYPhotoCollectionCell.swift
//  Utils
//
//  Created by liuhongli on 2021/2/5.
//

import UIKit

class ZJYPhotoCollectionCell: UICollectionViewCell {
    
    public var photo: String? {
        didSet {
            guard let photo = photo, let url = URL.init(string: photo) else {
                debugPrint("获取photo的url失败")
                return
            }
            self.scrollView.imageView.kf.setImage(with: url)
        }
    }
    
    lazy var scrollView: ZJYPhotoScrollView = {
        let v = ZJYPhotoScrollView.init()
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialUI() {
        self.contentView.addSubview(scrollView)
        scrollView.fillSuperview()
    }
    
    
    
    
}
