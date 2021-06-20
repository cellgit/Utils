//
//  CustomFlowLayout.swift
//  Utils
//
//  Created by 刘宏立 on 2021/6/15.
//

import Foundation
import UIKit

// 继承FlowLayout 可以减少一部分布局麻烦
class CustomFlowLayout: UICollectionViewFlowLayout {
    // 用于存放每个 item 的样式
    fileprivate lazy var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    override init() {
        super.init()
        // 设置布局为水平滚动
        scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 布局准备工作,主要用于计算每个 item 的位置
    override func prepare() {
        super.prepare()
        let itemCount = collectionView?.numberOfItems(inSection: 0)
        let itemW: CGFloat = SCREEN_WIDTH * 0.84
        let itemH: CGFloat = 250
        let margin: CGFloat = -30
        let left: CGFloat = (SCREEN_WIDTH - itemW - 2 * margin) / 2.0

        for index in 0..<itemCount! {
            let indexPath = IndexPath(item: index, section: 0)
            let atts = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let x = (itemW + margin) * CGFloat(index) +  margin + left
            
            atts.frame = CGRect(x: x, y: 0, width: itemW, height: itemH)
            attrsArray.append(atts)
        }
    }
    
    // 为每个 item 布局
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let size = collectionView?.frame.size
        let origin = collectionView?.contentOffset
        // 显示区域
        let visiableRect = CGRect(x: (origin?.x)!, y: (origin?.y)!, width: (size?.width)!, height: (size?.height)!)
        
        let centerX = (collectionView?.contentOffset.x)! + (collectionView?.frame.width)! * 0.5
        
        for att in attrsArray {
            if visiableRect.intersects(att.frame) {
                // 获取中心点
                let itemCenterX = att.center.x
                
                // 计算缩小的比例. fabsf是取绝对值的函数
                let scale = 1 - (fabsf(Float(itemCenterX - centerX))) / 1000.0
                                
                att.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
            }
        }
        
        return attrsArray
    }
    
    // ContentSize大小
    override var collectionViewContentSize: CGSize {
        return CGSize(width: (attrsArray.last?.frame.maxX)! + 30, height: 0)
    }
    
    // 当边界改变时调用此方法,可以频繁计算 item 的大小
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    

}


/// 当滚动停止时,停留到中间
extension CustomFlowLayout {
  // 滚动将要停止时调用
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        let lastRect = CGRect(origin: proposedContentOffset, size: (collectionView?.frame.size)!)
        
        // 屏幕中心的位置
        let centerX = proposedContentOffset.x + (collectionView?.frame.width)! * 0.5
        
        // 取出范围内的属性
        let array = layoutAttributesForElements(in: lastRect)
        var  adjustOffsetX: CGFloat = CGFloat(MAXFLOAT)
        
        for att in array! {
            if fabsf(Float(att.center.x - centerX)) < fabsf(Float(adjustOffsetX)) {
                adjustOffsetX = att.center.x - centerX
            }
        }
        return CGPoint(x: proposedContentOffset.x + adjustOffsetX, y: proposedContentOffset.y)
    }

}
