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
    /// contentView顶部圆角
    var cornerRadius: CGFloat = 8
}

class SheetAlertButton: UIButton {
    /// 列表最多显示几行
    private let kMaxCell: Int = 4
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
    /// 动画时间(弹框弹出世间)
    private var duration: TimeInterval = TimeInterval(200 / kVelocity)
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
    private let heightModel: SheetHeightModel
    
    init(mode: SheetStyle, data: [SheetCellModel], heightModel: SheetHeightModel = SheetHeightModel.init(padding: 0, margin: 0, button: 44, cornerRadius: 8)) {
        self.datalist = data
        self.heightModel = heightModel
        super.init(frame: .zero)
        contentView.frame = getContentViewFrame(data: data, heightModel: heightModel)
        setupUI()
        fadeInTransform()
        action()
    }
    
    /// tableView的高度
    private func getTableViewHeight(data: [SheetCellModel], heightModel: SheetHeightModel) -> CGFloat {
        var contentHeight: CGFloat = 0
        data.enumerated().forEach { [weak self] (index, item) in
            guard let `self`  = self else { return }
            if index < kMaxCell {
                contentHeight += item.height ?? 0
            }
        }
        return contentHeight
    }
    /// contentView的高度(总高度)
    private func getContentViewtHeight(data: [SheetCellModel], heightModel: SheetHeightModel) -> CGFloat {
        var contentHeight: CGFloat = 0
        for item in data {
            contentHeight += item.height ?? 0
        }
        let tableViewHeight = getTableViewHeight(data: data, heightModel: heightModel)
        contentHeight = tableViewHeight + heightModel.button + 2*heightModel.margin + heightModel.padding + Layout.safeViewHeight + heightModel.cornerRadius
        return contentHeight
    }
    /// contentView的frame
    private func getContentViewFrame(data: [SheetCellModel], heightModel: SheetHeightModel) -> CGRect {
        let contentHeight: CGFloat = getContentViewtHeight(data: data, heightModel: heightModel)
        return CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: contentHeight)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        /// 列表行数大于 kMaxCell 可以滑动
        tableView.isScrollEnabled = (datalist.count > kMaxCell)
        /// 设置一个初始的alpha值
        self.backgroundColor = UIColor.init(white: 1, alpha: 0.0)
        UIApplication.shared.windows.last?.addSubview(self)
        self.addSubview(contentView)
        contentView.addSubview(topView)
        contentView.addSubview(bottomButtonContainer)
        bottomButtonContainer.addSubview(bottomButton)
        contentView.addSubview(tableView)
        let tableViewHeight: CGFloat = getTableViewHeight(data: self.datalist, heightModel: self.heightModel)
        
        topView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(heightModel.cornerRadius)
        }
        
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(heightModel.cornerRadius)
            $0.height.equalTo(tableViewHeight)
        }
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

extension SheetAlertButton: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(SheetCell.self, indexPath)
//        cell.backgroundColor = .systemTeal
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
        debugPrint("indexPath.row===== \(indexPath.row)")
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
        contentView.layer.mask = cornerLayer(contentView, corner: [.topLeft, .topRight], radii: CGSize(width: heightModel.cornerRadius, height: heightModel.cornerRadius))
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
        if let isSeparator = model?.isSeparator {
            line.isHidden = !isSeparator
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
