//
//  SheetAlertButton.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

/**
 * Sheet 弹框
 *
 */

import UIKit

class SheetAlertButton: UIButton {
    /// 选中的选项回调: model选中想的数据
    open var selectedModel: ((_ model: SheetCellModel) -> Void)?
    /// 底部按钮选中回调: style样式
    open var selectedButton: (() -> Void)?
    
    struct Layout {
        static let safeViewHeight: CGFloat = isFullScreen ? 34 : 0
    }
    /// 底部按钮
    private lazy var bottomButton: UIButton = {
        let button = UIButton.init(type: .custom)
        return button
    }()
    /// 底部按钮容器
    private lazy var bottomButtonContainer: UIView = {
        let v = UIView.init()
        return v
    }()
    private lazy var safeView: UIView = {
        let view = UIView.init()
        view.backgroundColor = .white
        return view
    }()
    /// 顶部圆角部分的view: 高度为圆角大小
    private lazy var topView: UIView = {
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
    
    private lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.separatorStyle = .none
        table.register(SheetCell.self)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    /// 列表数据
    private let datalist: [SheetCellModel]
    /// 底部视图高度数据(为了初始化确定高度)
    private let configure: SheetConfigure
    
    init(data: [SheetCellModel], configure: SheetConfigure = SheetConfigure.init(padding: 0, margin: 0, buttonHeight: 44, cornerRadius: 8)) {
        self.datalist = data
        self.configure = configure
        super.init(frame: .zero)
        initialConfigure(configure: configure)
        contentView.frame = getContentViewFrame(data: data, configure: configure)
        setupUI()
        fadeInTransform()
        action()
    }
    
    func initialConfigure(configure: SheetConfigure) {
        /// 属性设置需要在这里进行更新
        bottomButton.setTitle(configure.buttonTitle, for: .normal)
        bottomButton.setTitleColor(configure.buttonTitleColor, for: .normal)
        bottomButton.titleLabel?.font = configure.buttonTitleFont
        bottomButton.backgroundColor = configure.buttonBackgroundColor
        bottomButtonContainer.backgroundColor = configure.bottomBackgroundColor
        safeView.backgroundColor = configure.bottomBackgroundColor
        contentView.backgroundColor = configure.contentViewBackgroundColor
        bottomButton.layer.masksToBounds = true
        bottomButton.layer.cornerRadius = configure.buttonCornerRadius
    }
    
    private func action() {
        /// 透明背景视图的事件
        self.action { [weak self] (sender) in
            guard let `self` = self else { return }
            self.fadeOutTransform()
        }
        
        /// 底部按钮的事件
        switch configure.style {
        case .cancel:
            self.bottomButton.action { [weak self] (sender) in
                guard let `self` = self else { return }
                self.fadeOutTransform()
                self.selectedButton?()
            }
            
        }
        
    }
    
    private func setupUI() {
        /// 列表行数大于 kMaxCell 可以滑动
        tableView.isScrollEnabled = (datalist.count > configure.maxRow)
        /// 设置一个初始的alpha值
        self.backgroundColor = UIColor.init(white: 1, alpha: 0.0)
        UIApplication.shared.windows.last?.addSubview(self)
        self.addSubview(contentView)
        contentView.addSubview(topView)
        contentView.addSubview(bottomButtonContainer)
        bottomButtonContainer.addSubview(bottomButton)
        contentView.addSubview(tableView)
        let tableViewHeight: CGFloat = getTableViewHeight(data: self.datalist, configure: self.configure)
        
        topView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(configure.cornerRadius)
        }
        
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(configure.cornerRadius)
            $0.height.equalTo(tableViewHeight)
        }
        self.fillSuperview()
        
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
            $0.height.equalTo(configure.buttonHeight + 2*configure.margin)
        }
        bottomButton.snp.remakeConstraints {
            $0.left.equalToSuperview().offset(configure.buttonLeftMargin)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-configure.buttonRightMargin)
            $0.height.equalTo(configure.buttonHeight)
        }
        rectCorner()
    }
    
    /// tableView的高度
    private func getTableViewHeight(data: [SheetCellModel], configure: SheetConfigure) -> CGFloat {
        var contentHeight: CGFloat = 0
        data.enumerated().forEach { (index, item) in
            if index < configure.maxRow {
                contentHeight += item.height ?? 0
            }
        }
        return contentHeight
    }
    /// contentView的高度(总高度)
    private func getContentViewtHeight(data: [SheetCellModel], configure: SheetConfigure) -> CGFloat {
        var contentHeight: CGFloat = 0
        for item in data {
            contentHeight += item.height ?? 0
        }
        let tableViewHeight = getTableViewHeight(data: data, configure: configure)
        contentHeight = tableViewHeight + configure.buttonHeight + 2*configure.margin + configure.padding + Layout.safeViewHeight + configure.cornerRadius
        return contentHeight
    }
    /// contentView的frame
    private func getContentViewFrame(data: [SheetCellModel], configure: SheetConfigure) -> CGRect {
        let contentHeight: CGFloat = getContentViewtHeight(data: data, configure: configure)
        return CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: contentHeight)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SheetAlertButton: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SheetCell.self, indexPath)
        if indexPath.row < datalist.count {
            cell.model = datalist[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        if indexPath.row < datalist.count {
            height = datalist[indexPath.row].height ?? 0
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let model = index(for: indexPath) {
            selectedModel?(model)
            self.fadeOutTransform()
        }
    }
    private func index(for indexPath: IndexPath) -> SheetCellModel? {
        guard indexPath.section < datalist.count else { return nil }
        return datalist[indexPath.row]
    }
    
}

/// 动画
extension SheetAlertButton {
    
    func fadeInTransform() {
        let y: CGFloat = -(self.contentView.bounds.size.height)
        UIView.animate(withDuration: configure.duration, delay: 0.0, options: .curveEaseIn, animations: {
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
            self.contentView.transform = CGAffineTransform(translationX: 0, y: y)
            self.rectCorner()
        }, completion: nil)
    }
    
    func fadeOutTransform() {
        UIView.animate(withDuration: configure.duration, delay: 0.0, options: .curveEaseIn, animations: {
            self.backgroundColor = UIColor.init(white: 0, alpha: 0.0)
            self.contentView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (true) in
            self.removeFromSuperview()
        }
    }
    
    // 设置contentView圆角路径
    func rectCorner() {
        /// 注意: 这里切圆角需要被切得视图用frame布局
        contentView.layer.mask = cornerLayer(contentView, corner: [.topLeft, .topRight], radii: CGSize(width: configure.cornerRadius, height: configure.cornerRadius))
    }
    
    private func cornerLayer(_ view: UIView, corner: UIRectCorner, radii: CGSize) -> CALayer {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corner, cornerRadii: radii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = path.cgPath
        return maskLayer
    }
}


/// SheetCell 自定义
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
        v.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
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
        if let isHiddenSeparator = model?.isHiddenSeparator {
            line.isHidden = isHiddenSeparator
        }
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
