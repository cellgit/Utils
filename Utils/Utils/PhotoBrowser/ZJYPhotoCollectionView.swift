//
//  ZJYPhotoCollectionView.swift
//  Utils
//
//  Created by 刘宏立 on 2021/2/5.
//

import UIKit


enum StepActionType {
    case previous
    case next
}

class ZJYPhotoCollectionView: UICollectionView {
    
    /// 切换cell,前一页或下一页
    public var changePageAction: ((_ type: StepActionType) -> Void)?
    
    public var didScrollToPage: ((_ current: Int, _ total: Int) -> Void)?
    
    private let KZJYPhotoCollectionCell = "ZJYPhotoCollectionCell"
    
    struct Layout {
        static let itemHeight: CGFloat = SCREEN_HEIGHT
        static let itemWidth: CGFloat = SCREEN_WIDTH
        static let itemPadding: CGFloat = 0//16*scale_w
        
        static let pageLabelHeight: CGFloat = 19
        static let pageLabelWidth: CGFloat = 60
        static let pageLabelBottomMargin: CGFloat = isFullScreen ? 20 + 34 : 20
        static let pageLabelLeftMargin: CGFloat = 20
    }

    let photos: [String]
    
    private var currentPage: Int = -1 {
        didSet {
            didScrollToPage?(currentPage, photos.count)
        }
    }
    
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
    
    init(photos: [String]) {
        self.photos = photos
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Layout.itemPadding
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        super.init(frame: .zero, collectionViewLayout: layout)
        self.initialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialUI() {
        self.currentPage = 0
        self.register(ZJYPhotoCollectionCell.self, forCellWithReuseIdentifier: KZJYPhotoCollectionCell)
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .lightGray
        self.isScrollEnabled = true
        self.delegate = self
        self.dataSource = self
        self.isPagingEnabled = true
        
        self.changePageAction = { [weak self] type in
            guard let `self` = self else { return }
            type == .next ? self.nextPage() : self.previousPage()
        }
        
        
    }
    
    func previousPage() {
        if self.currentPage <= 0 { return }
        else {
            sendNotification()
            self.currentPage = self.currentPage - 1
            var contentOffset = CGFloat(self.currentPage) * 1*(Layout.itemWidth+Layout.itemPadding)
            //最小偏移
            let minOffset: CGFloat = 0
            //偏移
            contentOffset = contentOffset < minOffset ? minOffset : contentOffset
            self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
        }
    }
    func nextPage() {
        //最大页数为(count / 1)  - 1
        if self.currentPage < photos.count / 1 - 1 {
            sendNotification()
            self.currentPage = self.currentPage + 1
            var contentOffset = CGFloat(self.currentPage) * 1*(Layout.itemWidth+Layout.itemPadding)
            //最大偏移
            let maxOffset = self.contentSize.width - self.frame.width
            //偏移
            contentOffset = contentOffset > maxOffset ? maxOffset : contentOffset
            self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
        } else { return }
    }
    
}

extension ZJYPhotoCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
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
    
}


extension ZJYPhotoCollectionView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset_x = scrollView.contentOffset.x
//        let row: Int = Int(offset_x / (1*Layout.itemWidth+Layout.itemPadding))
        let row = Int(round(offset_x / (1*Layout.itemWidth+Layout.itemPadding)))
        if row != currentPage {
            sendNotification()
        }
        self.currentPage = row
    }
    
}

extension ZJYPhotoCollectionView {
    /// 通知
    func sendNotification() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: KPhotoBroswerImageChangedNotification), object: nil, userInfo: nil)
    }
    
}
