//
//  PCoverTitleView.swift
//  Utils
//
//  Created by liuhongli on 2021/1/20.
//


/**
 * 对第三方库 PagingViewKit 中的 PagingTitleView 的封装
 */

import UIKit
import PagingViewKit

class PCoverTitleView: UIView, PagingTitleViewDelegate {
    
    /// 选中项索引的回调
    open var selectedItem: ((_ index: Int) -> Void)?
    
    /// 赋值title
    open var titles: [String] = [] {
        didSet {
            if pagingTitleView != nil {
                titles.enumerated().forEach { [weak self] (index, item) in
                    guard let `self` = self else {return}
                    self.pagingTitleView.resetTitle(text: item, index: index)
                }
            }
        }
    }
    
    /// 重置选中索引
    open var resetIndex: Int = 0 {
        didSet {
            if pagingTitleView != nil {
                pagingTitleView.resetIndex = resetIndex
            }
        }
    }
    
    private var pagingTitleView: PagingTitleView!
    
    init(titles: [String] = [],
         _ indicatorColor: UIColor = UIColor(red: 0.073, green: 0.733, blue: 0.456, alpha: 1),
         _ normalTitleColor: UIColor = .lightGray,
         _ selectedTitleColor: UIColor = .white,
         _ font: UIFont = UIFont.systemFont(ofSize: 12),
         _ selectedFont: UIFont = UIFont.systemFont(ofSize: 15),
         _ additionalWidth: CGFloat = 32
    ) {
        super.init(frame: .zero)
            initial(titles: titles, indicatorColor, normalTitleColor, selectedTitleColor, font, selectedFont, additionalWidth)
        
        
    }
    
    func initial(titles: [String],
                 _ indicatorColor: UIColor = UIColor(red: 0.073, green: 0.733, blue: 0.456, alpha: 1),
                 _ normalTitleColor: UIColor = .lightGray,
                 _ selectedTitleColor: UIColor = .white,
                 _ font: UIFont = UIFont.systemFont(ofSize: 12),
                 _ selectedFont: UIFont = UIFont.systemFont(ofSize: 15),
                 _ additionalWidth: CGFloat = 32
                 ) {
        let configure: PagingTitleViewConfigure = PagingTitleViewConfigure()
        configure.indicatorType = .Cover
        configure.indicatorColor = indicatorColor //UIColor(red: 0.073, green: 0.733, blue: 0.456, alpha: 1)
        configure.indicatorHeight = 28
        configure.indicatorCornerRadius = 14
        configure.indicatorAdditionalWidth = 28
        configure.additionalWidth = additionalWidth
        configure.selectedColor = selectedTitleColor//.white
        configure.color = normalTitleColor
        configure.font = font//UIFont.systemFont(ofSize: 12)
        configure.selectedFont = selectedFont
        configure.showBottomSeparator = false
        pagingTitleView = PagingTitleView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH-40, height: 44), titles: titles, delegate: self, configure: configure)
        self.addSubview(pagingTitleView)
//        pagingTitleView.backgroundColor = .systemTeal
    }
    
    func pagingTitleView(pagingTitleView: PagingTitleView, index: Int) {
        debugPrint("pagingTitleView====== \(index)")
        self.selectedItem?(index)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
