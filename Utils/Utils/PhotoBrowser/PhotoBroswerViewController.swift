//
//  PhotoBroswerViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/2/5.
//

import UIKit
import SKPhotoBrowser
import SnapKit
import Kingfisher

class PhotoBroswerViewController: UIViewController {
    
    
    lazy var photos: [String] = {
        var urls: [String] = []
        for item in 0...300 {
            let url = "https://test-rj.zjyjc.com/api/media/api/v1/media/showImage/conf::bookFileKey:a9ee2162d38c01e86b8c4bc5cd9ff4ba"
            
            //conf::bookFileKey:0447f93060bd92d73dc5dae38e2cd231
            
            urls.append(url)
        }
        return urls
    }()
    
    
//    let photos = ["https://test-rj.zjyjc.com/api/media/api/v1/media/showImage/conf::bookFileKey:0447f93060bd92d73dc5dae38e2cd231",
//    "https://test-rj.zjyjc.com/api/media/api/v1/media/showImage/conf::bookFileKey:0447f93060bd92d73dc5dae38e2cd231",
//    "https://test-rj.zjyjc.com/api/media/api/v1/media/showImage/conf::bookFileKey:0447f93060bd92d73dc5dae38e2cd231",
//    "https://test-rj.zjyjc.com/api/media/api/v1/media/showImage/conf::bookFileKey:0447f93060bd92d73dc5dae38e2cd231"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        
        let broswerView: ZJYPhotoBroswerView = ZJYPhotoBroswerView.init(photos: photos)
        
        self.view.addSubview(broswerView)
        broswerView.backgroundColor = .cyan
        
        broswerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(self.view).offset(88)
        }
        
    }
    

    

}
