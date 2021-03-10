//
//  ListTableViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit

class ListTableViewController: UITableViewController {
        
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
        return ExampleEnum.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(ExampleEnum.allCases[indexPath.row].self)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        debugPrint("indexPath.row======= \(indexPath.row)")
        
        switch indexPath.row {
        case ExampleEnum.alert.rawValue:
            let alertViewController = AlertListTableViewController.init(style: .plain)
            self.navigationController?.pushViewController(alertViewController, animated: true)
        case ExampleEnum.sheet.rawValue:
            let alertViewController = SheetListTableViewController.init(style: .plain)
            self.navigationController?.pushViewController(alertViewController, animated: true)
        case ExampleEnum.linedLabel.rawValue:
            let alertViewController = ViewController.init()
            self.navigationController?.pushViewController(alertViewController, animated: true)
        case ExampleEnum.pickerView.rawValue:
            let list = ["全部","三年级","四年级","五年级","六年级"]
            let pickerView = PopPickerView.init(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: 307 + (is_iPhoneX ? 34 : 0)), datalist: list,title: "年级选择", selectedRow: 2)
            
            pickerView.rowAndComponentCallBack = {(resultStr) in
                print(resultStr as Any)
                debugPrint("resultStr===== \(resultStr)")
            }
            pickerView.show()
        case ExampleEnum.photoBroswer.rawValue:
            let vc = PhotoBroswerViewController.init()
//            self.present(vc, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        case ExampleEnum.vlcPlayer.rawValue:
            let vc = VLCPlayerViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
