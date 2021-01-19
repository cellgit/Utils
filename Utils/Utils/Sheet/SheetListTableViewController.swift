//
//  SheetListTableViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit

class SheetListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        self.tableView.register(UITableViewCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SheetStyle.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)

        cell.textLabel?.text = "\(SheetStyle.allCases[indexPath.row].self)"

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case SheetStyle.cancel.rawValue:
            let model1 = SheetCellModel.init(identifier: "1", title: "first", font: UIFont.systemFont(ofSize: 14), titleColor: UIColor.gray, isSeparator: true, height: 50)
            let model2 = SheetCellModel.init(identifier: "2", title: "second", font: UIFont.systemFont(ofSize: 14), titleColor: UIColor.gray, isSeparator: true, height: 50)
            let model3 = SheetCellModel.init(identifier: "3", title: "third", font: UIFont.systemFont(ofSize: 14), titleColor: UIColor.gray, isSeparator: true, height: 50)
            let model4 = SheetCellModel.init(identifier: "4", title: "fourth", font: UIFont.systemFont(ofSize: 14), titleColor: UIColor.gray, isSeparator: true, height: 50)
            
            let data: [SheetCellModel] = [model1,model2,model3,model4]
            
            let heightModel = SheetHeightModel.init(padding: 100, margin: 100, button: 50)
            
            let alert = SheetAlertButton.init(mode: .cancel, data: data, heightModel: heightModel)
            alert.bottomButtonTitle = "取消"
            alert.contentViewCornerRadius = 20
            alert.bottomButtonLeftMargin = 40
            alert.bottomButtonRightMargin = 40
            alert.bottomButtonCornerRadius = 50 / 2
            alert.bottomBackgroundColor = .systemTeal
            alert.bottomButtonBackgroundColor = .lightGray
            
        default:
            break
        }
    }



}
