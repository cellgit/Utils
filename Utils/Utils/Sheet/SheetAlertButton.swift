//
//  SheetAlertButton.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

/**
 * 壳子: 底部有一个按钮
 *
 */

/// 动画速度
let kVelocity: CGFloat = 1000

import UIKit

struct SheetHeightModel {
    /// 列表和底部按钮容器的间距
    var padding: CGFloat = 0
    /// 按钮容器与按钮底部或顶部的间距
    var margin: CGFloat = 0
    /// 按钮的高度
    var button: CGFloat = 44
}

class SheetAlertButton: UIButton {
    
    
    
    struct Layout {
        static let safeViewHeight: CGFloat = isFullScreen ? 34 : 0
    }
    
    /// 底部按钮的标题
    open var bottomButtonTitle: String? = "取消" {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /// 底部按钮的标题颜色
    open var bottomButtonTitleColor: UIColor? = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1) {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /// 底部按钮的标题字号
    open var bottomButtonTitleFont: UIFont? = UIFont.systemFont(ofSize: 14) {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /// 底部按钮左边间距
    open var bottomButtonLeftMargin: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    /// 底部按钮右边间距
    open var bottomButtonRightMargin: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    
//    /// 底部按钮和列表的间距
//    open var padding: CGFloat = 0 {
//        didSet {
//            layoutIfNeeded()
//        }
//    }
    
    /// 内容视图的圆角大小
    open var contentViewCornerRadius: CGFloat = 4 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    /// 底部按钮容器和safeView颜色
    var bottomBackgroundColor: UIColor = .white {
        didSet {
            layoutIfNeeded()
        }
    }
    /// 底部按钮的背景色
    var bottomButtonBackgroundColor: UIColor = .white {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var bottomButtonCornerRadius: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    
    /// 内容视图的背景色
    var contentViewBackgroundColor: UIColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1) {
        didSet {
            layoutIfNeeded()
        }
    }
    
    
    private var duration: TimeInterval = 0.38
    
    private lazy var bottomButton: UIButton = {
        let button = UIButton.init(type: .custom)
        return button
    }()
    
    private lazy var bottomButtonContainer: UIView = {
        let v = UIView.init()
        return v
    }()
    
    private lazy var safeView: UIView = {
        let view = UIView.init()
        view.backgroundColor = .white
        return view
    }()
    /// 承载底部按钮和列表
    private lazy var contentView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    private var contentHeight: CGFloat = 0
    
    
    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.separatorStyle = .none
        
        return table
    }()
    
    private let heightModel: SheetHeightModel

    init(mode: SheetStyle, data: [SheetCellModel], heightModel: SheetHeightModel = SheetHeightModel.init(padding: 0, margin: 0, button: 44)) {
        self.heightModel = heightModel
        super.init(frame: .zero)
        
        for item in data {
            contentHeight += item.height ?? 0
        }
        
        contentHeight = contentHeight + heightModel.button + 2*heightModel.margin + heightModel.padding + Layout.safeViewHeight
        
        contentView.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: contentHeight)
        
        self.duration = TimeInterval(200 / kVelocity)
        
        setupUI()
        
        fadeInTransform()

        action()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        /// 设置一个初始的alpha值
        self.backgroundColor = UIColor.init(white: 1, alpha: 0.0)
        UIApplication.shared.windows.last?.addSubview(self)
        self.addSubview(contentView)
        
        contentView.addSubview(bottomButtonContainer)
        bottomButtonContainer.addSubview(bottomButton)
        
        self.fillSuperview()
        layout()
    }
    
    
    override func layoutIfNeeded() {
        
        /// 属性设置需要在这里进行更新
        bottomButton.setTitle(bottomButtonTitle, for: .normal)
        bottomButton.setTitleColor(self.bottomButtonTitleColor, for: .normal)
        bottomButton.titleLabel?.font = self.bottomButtonTitleFont
        bottomButton.backgroundColor = bottomButtonBackgroundColor
        bottomButtonContainer.backgroundColor = bottomBackgroundColor
        safeView.backgroundColor = bottomBackgroundColor
        contentView.backgroundColor = contentViewBackgroundColor
        bottomButton.layer.masksToBounds = true
        bottomButton.layer.cornerRadius = bottomButtonCornerRadius
        
        layout()
    }
    
    
    func layout() {
        if isFullScreen {
            contentView.addSubview(safeView)
            safeView.snp.remakeConstraints {
                $0.left.bottom.right.equalToSuperview()
                $0.height.equalTo(Layout.safeViewHeight)
            }
        }
        
        bottomButtonContainer.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-Layout.safeViewHeight)
            $0.height.equalTo(heightModel.button + 2*heightModel.margin)
        }
        
        bottomButton.snp.remakeConstraints {
            $0.left.equalToSuperview().offset(bottomButtonLeftMargin)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-bottomButtonRightMargin)
            $0.height.equalTo(heightModel.button)
        }
        
        rectCorner()
        
    }
    
    
}


/// 底部button事件
extension SheetAlertButton {
    func action() {
        action { [weak self] (sender) in
            guard let `self` = self else { return }
            self.fadeOutTransform()
        }
    }
}



/// 动画
extension SheetAlertButton {
    
    func fadeInTransform() {
        let y: CGFloat = -(self.contentView.bounds.size.height)
//        debugPrint("y===== \(-200)")
        UIView.animate(withDuration: self.duration, delay: 0.0, options: .curveEaseIn, animations: {
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
            self.contentView.transform = CGAffineTransform(translationX: 0, y: y)
            self.rectCorner()
        }, completion: nil)
    }
    
    func fadeOutTransform() {
        UIView.animate(withDuration: self.duration, delay: 0.0, options: .curveEaseIn, animations: {
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.0)
            self.contentView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (true) in
            self.removeFromSuperview()
        }
    }
    
    // 设置contentView圆角路径
    func rectCorner() {
        /// 注意: 这里切圆角需要被切得视图用frame布局
        contentView.layer.mask = cornerLayer(contentView, corner: [.topLeft, .topRight], radii: CGSize(width: contentViewCornerRadius, height: contentViewCornerRadius))
    }
    
    private func cornerLayer(_ view: UIView, corner: UIRectCorner, radii: CGSize) -> CALayer {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corner, cornerRadii: radii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = path.cgPath
        return maskLayer
    }
}




class SheetCell: UITableViewCell {
    
    open var model: SheetCellModel? {
        didSet {
            configure(model: model)
        }
    }
    
    
    lazy var titleLabel: UILabel = {
        let l = UILabel.init()
        l.textAlignment = .center
        return l
    }()
    
    private var line: UIView = {
        let v = UIView.init()
        v.backgroundColor = .gray
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initial()
    }
    
    
    func configure(model: SheetCellModel?) {
        titleLabel.text = model?.title
        titleLabel.textColor = model?.titleColor
        titleLabel.font = model?.font
        line.isHidden = !(model?.isSeparator != nil)
    }
    
    
    func initial() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(line)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        line.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
