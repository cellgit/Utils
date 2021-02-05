//
//  ZJYPhotoBroswerView.swift
//  Utils
//
//  Created by liuhongli on 2021/2/5.
//

import UIKit

class ZJYPhotoBroswerView: UIView {
    
    struct Layout {
        static let lastBtnWidth: CGFloat = 20
        static let lastBtnHeight: CGFloat = 20
        static let itemHeight: CGFloat = SCREEN_HEIGHT
        static let itemWidth: CGFloat = SCREEN_WIDTH
        static let itemPadding: CGFloat = 0//16*scale_w
        
        static let pageLabelHeight: CGFloat = 19
        static let pageLabelWidth: CGFloat = 60
        static let pageLabelBottomMargin: CGFloat = isFullScreen ? 20 + 34 : 20
        static let pageLabelLeftMargin: CGFloat = 20
    }
    
    var currentPage: Int = 0
    
    lazy var lastBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "home_arrow_left"), for: .normal)
        self.addSubview(btn)
        btn.backgroundColor = .systemTeal
        return btn
    }()

    lazy var nextBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setImage(UIImage.init(named: "home_arrow_right"), for: .normal)
        self.addSubview(btn)
        btn.backgroundColor = .systemTeal
        return btn
    }()
    
    private let KZJYPhotoCollectionCell = "ZJYPhotoCollectionCell"
    
    let photos: [String]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Layout.itemPadding
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        let collectionView = UICollectionView.init(frame: self.frame, collectionViewLayout: layout)
        collectionView.register(ZJYPhotoCollectionCell.self, forCellWithReuseIdentifier: KZJYPhotoCollectionCell)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .lightGray
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        
        return collectionView
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
    
    
    init(photos: [String]) {
        self.photos = photos
        super.init(frame: .zero)
        
        self.initialUI()
        self.initialPageButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialUI() {
        self.addSubview(collectionView)
        collectionView.backgroundColor = .magenta
        self.addSubview(pageLabel)
        
        pageLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Layout.pageLabelLeftMargin)
            $0.bottom.equalToSuperview().offset(-Layout.pageLabelBottomMargin)
            $0.height.equalTo(Layout.pageLabelHeight)
        }
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func initialPageButton() {
        lastBtn.action { [weak self](sender) in
            self?.lastPage()
        }
        nextBtn.action { [weak self](sender) in
            self?.nextPage()
        }
        lastBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(collectionView)
            make.left.equalTo(self)
            make.width.equalTo(Layout.lastBtnWidth)
            make.height.equalTo(Layout.lastBtnHeight)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(collectionView)
            make.right.equalTo(self)
            make.width.equalTo(Layout.lastBtnWidth)
            make.height.equalTo(Layout.lastBtnHeight)
        }
    }
    func lastPage() {
        if self.currentPage <= 0 {
            return
        } else {
            self.currentPage = self.currentPage - 1
            var contentOffset = CGFloat(self.currentPage) * 1*(Layout.itemWidth+Layout.itemPadding)
            //最小偏移
            let minOffset: CGFloat = 0
            //偏移
            contentOffset = contentOffset < minOffset ? minOffset : contentOffset
            self.collectionView.setContentOffset(CGPoint(x: contentOffset, y: self.collectionView.contentOffset.y), animated: true)
        }
    }
    
    
    func nextPage() {
        //最大页数为(count / 1)  - 1
        if self.currentPage < photos.count / 1 {
            self.currentPage = self.currentPage + 1
            var contentOffset = CGFloat(self.currentPage) * 1*(Layout.itemWidth+Layout.itemPadding)
            //最大偏移
            let maxOffset = collectionView.contentSize.width - collectionView.frame.width
            //偏移
            contentOffset = contentOffset > maxOffset ? maxOffset : contentOffset
//            debugPrint("==== \(self.collectionView.contentOffset.y)")
            self.collectionView.setContentOffset(CGPoint(x: contentOffset, y: self.collectionView.contentOffset.y), animated: true)
        } else {
            return
        }
    }
    
    
}


extension  ZJYPhotoBroswerView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ZJYPhotoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: KZJYPhotoCollectionCell, for: indexPath) as! ZJYPhotoCollectionCell
        if photos.count > indexPath.row {
            cell.photo = photos[indexPath.row]
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ZJYPhotoCollectionCell
        cell?.scrollView.zoomScale = 0.3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
    
    
    
}
extension ZJYPhotoBroswerView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset_x = scrollView.contentOffset.x
        let row: Int = Int(offset_x / (1*Layout.itemWidth+Layout.itemPadding))
        self.currentPage = row
    }
    
}
