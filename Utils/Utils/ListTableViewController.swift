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
        default:
            break
        }
    }
    
}
