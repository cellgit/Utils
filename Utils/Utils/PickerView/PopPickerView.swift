//
//  PopPickerView.swift
//  Utils
//
//  Created by liuhongli on 2021/1/21.
//

import Foundation
import UIKit

typealias PopPickerViewCallBackClosure = (_ index: Int) -> Void

class PopPickerView : UIView
{
    var dismissCallBack = {}
    var rowAndComponentCallBack: PopPickerViewCallBackClosure?
    
    fileprivate var selectedIndex : Int = 0
    
    let mainColor: UIColor = UIColor(red: 0.073, green: 0.733, blue: 0.456, alpha: 1)
    
    var titleLabel : UILabel?
    var divideLine : UIView?
    var confirmButton : UIButton?
    var cancelButton : UIButton?
    var overlayView : UIControl?
    var keyWindow : UIWindow?
    
    var toolView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white;
        
        if (keyWindow == nil) {
            self.keyWindow = UIApplication.shared.keyWindow
        }
        
        overlayView = UIControl.init(frame: UIScreen.main.bounds)
        overlayView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        overlayView?.addTarget(self, action: #selector(hide), for: .touchUpInside)
        overlayView?.alpha = 0
        
        toolView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Int(self.bounds.size.width), height: Int(52)))
        toolView.backgroundColor = .white
        addSubview(toolView)
        
        cancelButton = UIButton.init(frame: CGRect.init(x: 18, y: 0, width: 40, height: toolView.bounds.size.height))
        cancelButton?.setTitle("取消", for: .normal)
        let cancelColor = UIColor.init(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        cancelButton?.setTitleColor(cancelColor, for: .normal)
        cancelButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cancelButton?.contentHorizontalAlignment = .left
        cancelButton?.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        toolView.addSubview(cancelButton!)
        
        confirmButton = UIButton.init(frame: CGRect.init(x: (toolView.bounds.size.width - 30 - 18), y: 0, width: 30, height: toolView.bounds.size.height))
        confirmButton?.setTitle("确定", for: .normal)
        confirmButton?.setTitleColor(mainColor, for: .normal)
        confirmButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        confirmButton?.contentHorizontalAlignment = .left
        confirmButton?.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        toolView.addSubview(confirmButton!)
        
        titleLabel = UILabel.init(frame: CGRect(x: CGFloat(Int(self.bounds.size.width)/2 - 75), y: 0, width: 150, height: toolView.bounds.size.height))
        titleLabel?.text = "年级选择"
        titleLabel?.textColor = UIColor.init(red: 30/255, green: 30/255, blue: 1/255, alpha: 1.0)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel?.textAlignment = .center
        toolView.addSubview(titleLabel!)
        
        divideLine = UIView.init(frame: CGRect(x: 0, y: (confirmButton?.superview?.frame.maxY)!, width: toolView.bounds.size.width, height: 1))
        divideLine?.backgroundColor = .clear
        toolView.addSubview(divideLine!)
    }
    
    convenience init(frame: CGRect, datalist: [String], title:String, selectedRow: Int) {
        self.init(frame: frame)
        self.selectedIndex = selectedRow
        titleLabel?.text = title
        if (datalist.count != 0) {
            let picker = PickerViewBuilder.init(frame: CGRect.init(x: 38, y: 40, width: UIScreen.main.bounds.size.width - CGFloat(76), height: CGFloat(frame.height - 50 - (is_iPhoneX ? 34 : 0))),datalist: datalist, selectedRow: selectedRow, contentCallBack:{ [weak self] (index) in
                
                guard let `self` = self else {return}
                
                self.selectedIndex = index
            })
            picker.rowAndComponentCallBack = {[weak self](index) in
                guard let `self` = self else { return }
                self.selectedIndex = index
            }
            self.addSubview(picker)
        }else{
            assert(datalist.count != 0, "dataSource is not allowed to be nil")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(){
        keyWindow?.addSubview(overlayView!)
        keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: {
            self.overlayView?.alpha = 1.0
            var frame = self.frame
            frame.origin.y = UIScreen.main.bounds.size.height - self.bounds.size.height
            self.frame = frame
        }) { (isFinished) in
        }
    }
    
    @objc func hide() {
        self.dismissCallBack()
        UIView.animate(withDuration: 0.25, animations: {
            self.overlayView?.alpha = 0
            var frame = self.frame
            frame.origin.y = UIScreen.main.bounds.size.height
            self.frame = frame
        }) { (isFinished) in
            self.overlayView?.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    @objc func cancelAction() {
        hide()
    }
    
    @objc func confirmAction() {
        self.rowAndComponentCallBack?(selectedIndex)
        hide()
    }
    
    @objc private func showAlert(withTitle title: String?, message: String?) {
        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertVc.addAction(UIAlertAction.init(title: "我知道了", style: UIAlertAction.Style.cancel, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVc, animated: true, completion: nil)
    }
}

class PickerViewBuilder : UIPickerView, UIPickerViewDelegate,UIPickerViewDataSource {
    
    let mainColor: UIColor = UIColor(red: 0.073, green: 0.733, blue: 0.456, alpha: 1)
    let normalColor: UIColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    
    let rowheight: CGFloat = 50
    
    fileprivate var rowAndComponentCallBack: PopPickerViewCallBackClosure?//选择内容回调
    
    lazy var currentSelectRow : Int = 0
    
    lazy var dataArr: [String] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame:CGRect,datalist: [String], selectedRow: Int ,contentCallBack: PopPickerViewCallBackClosure?) {
        self.init(frame: frame)
        self.dataArr = datalist
        self.currentSelectRow = selectedRow
        self.backgroundColor = UIColor.white
        self.delegate = self
        self.dataSource = self
        
        self.selectRow(selectedRow, inComponent: 0, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        //设置分割线
        for view in pickerView.subviews {
            if view.frame.size.height <= rowheight+2 {
                view.isHidden = false
                view.frame = CGRect(x: 0, y: view.frame.origin.y, width: UIScreen.main.bounds.size.width, height: rowheight+2)
                view.backgroundColor = .clear
                let line1 = UIView.init(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0.5))
                view.addSubview(line1)
                line1.backgroundColor = mainColor
                let line2 = UIView.init(frame: CGRect(x: 0, y: view.bounds.height-1, width: view.bounds.width, height: 0.5))
                view.addSubview(line2)
                line2.backgroundColor = mainColor
            }
        }
        
        var pickerLabel = view as? UILabel
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.textAlignment = .center
            if currentSelectRow == row {
                pickerLabel?.font = UIFont.systemFont(ofSize: 18)
                pickerLabel?.textColor = mainColor
            }else{
                pickerLabel?.font = UIFont.systemFont(ofSize: 14)
                pickerLabel?.textColor = normalColor
            }
            
        }
        
        pickerLabel?.text = dataArr[row]
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return rowheight
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectRow = row
        rowAndComponentCallBack?(currentSelectRow)
        self.reloadAllComponents()
    }
}
