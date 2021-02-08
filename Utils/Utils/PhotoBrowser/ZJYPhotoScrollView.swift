//
//  ZJYPhotoScrollView.swift
//  Utils
//
//  Created by liuhongli on 2021/2/5.
//

import UIKit

let KPhotoBroswerImageChangedNotification = "PhotoBroswerImageChangedNotification"

class ZJYPhotoScrollView: UIScrollView, UIScrollViewDelegate {
    
    public var imageView: UIImageView!
    
    private var isZoom: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        imageView = UIImageView.init(frame: self.bounds)
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
//        imageView.fillSuperview()
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(SCREEN_WIDTH)
            $0.width.equalTo(SCREEN_HEIGHT)
        }
        
        self.delegate = self
        self.maximumZoomScale = 2
        self.minimumZoomScale = 1
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
        singleTap.require(toFail: doubleTap)
        addGestureRecognizer(singleTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(imageChanged(noti:)), name: NSNotification.Name(rawValue: KPhotoBroswerImageChangedNotification), object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        debugPrint("handleDoubleTap")
        isZoom == false ? toMaximumZoomScale() : toMinimumZoomScale()
    }
    @objc func handleSingleTap(sender: UITapGestureRecognizer) {
        debugPrint("handleSingleTap")
        toMinimumZoomScale()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func toMinimumZoomScale() {
        setZoomScale(minimumZoomScale, animated: true)
        isZoom = false
    }
    
    func toMaximumZoomScale() {
        setZoomScale(maximumZoomScale, animated: true)
        isZoom = true
    }
    
    @objc func imageChanged(noti: Notification) {
        toMinimumZoomScale()
    }
    
    
}
