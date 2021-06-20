//
//  SWFlowLayoutViewController.swift
//  Utils
//
//  Created by 刘宏立 on 2021/6/15.
//

import UIKit

class SWFlowLayoutViewController: UIViewController {
    
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = CustomFlowLayout.init()
        
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.register(CustomFlowLayoutCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
//        collectionView.contentInset = UIEdgeInsets.init(horizontal: SCREEN_WIDTH, vertical: 0)
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: SCREEN_WIDTH, bottom: 0, right: SCREEN_WIDTH)
        collectionView.backgroundColor = .orange
        collectionView.isPagingEnabled = false
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    

    

}

extension SWFlowLayoutViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomFlowLayoutCell.self, for: indexPath)
        let cell = collectionView.dequeueReusableCell(CustomFlowLayoutCell.self, indexPath)
        
        if indexPath.row == 0 {
            cell.titleLabel.text = "333333"
        }
        else if indexPath.row == 1  {
            cell.titleLabel.text = "33"
        }
        
        else if indexPath.row == 2  {
            cell.titleLabel.text = "33asvdavvjnsdjkvnjdav"
        }
        else if indexPath.row == 4  {
            cell.titleLabel.text = "jkvnjdav"
        }
        else  {
            cell.titleLabel.text = "dav"
        }
        
        return cell
    }

    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("========")
    }
    
    
    
    
}

extension SWFlowLayoutViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset_x = scrollView.contentOffset.x
        let width: CGFloat = scrollView.bounds.width
        print(width)
        let row: Int = Int(offset_x / width)
//        self.currentPage = row
        print("contentOffset1 ===== \(offset_x), ==== \(row)")
        
//        collectionView.scrollToItem(at: IndexPath.init(row: row, section: 0), at: .centeredHorizontally, animated: true)
        
        
        
        
    }
    
    
    

    
}

