//
//  ProgrammaListViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/3/12.
//

import UIKit

class ProgrammaListViewController: UITableViewController {
    
    enum ProgrammaEnum: Int,CaseIterable {
        case generics = 0
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.tableView.register(UITableViewCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProgrammaEnum.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(ProgrammaEnum.allCases[indexPath.row].self)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        debugPrint("indexPath.row======= \(indexPath.row)")
        
        switch indexPath.row {
        case ProgrammaEnum.generics.rawValue:
            let alertViewController = GenericsViewController.init()
            self.navigationController?.pushViewController(alertViewController, animated: true)
        default:
            break
        }
    }
    

}
