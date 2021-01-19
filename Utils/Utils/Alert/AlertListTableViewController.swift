//
//  AlertListTableViewController.swift
//  Utils
//
//  Created by liuhongli on 2021/1/18.
//

import UIKit
import SwiftEntryKit

class AlertListTableViewController: UITableViewController {
    
    private lazy var attributesWrapper: EntryAttributeWrapper = {
        var attributes = EKAttributes()
        attributes.positionConstraints = .fullWidth
        attributes.hapticFeedbackType = .success
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.entryBackground = .visualEffect(style: .standard)
        return EntryAttributeWrapper(with: attributes)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(UITableViewCell.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlertStyle.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(AlertStyle.allCases[indexPath.row].self)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case AlertStyle.style0.rawValue:
//            var attributes = EKAttributes()
//            attributes.displayDuration = 2
//            attributes.displayMode = .dark
//            attributes.windowLevel = .normal
//            attributes.position = .center
//            let customView = SomeCustomView.init(frame: CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width - 200, height: UIScreen.main.bounds.height - 200))
//            SwiftEntryKit.display(entry: customView, using: attributes)
        
            // Create a basic toast that appears at the top
//            var attributes = EKAttributes.centerFloat
//
//            // Set its background to white
//            attributes.entryBackground = .color(color: .white)
//
//            // Animate in and out using default translation
//            attributes.entranceAnimation = .translation
//            attributes.exitAnimation = .translation
////            attributes.position = .center
//
//            let customView = UIView()
//            /*
//            ... Customize the view as you like ...
//            */
//
//            // Display the view with the configuration
//            SwiftEntryKit.display(entry: customView, using: attributes)
        
            let vc = AlertStyleZeroViewController.init()
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
    

}



extension AlertListTableViewController {
    
}


class EntryAttributeWrapper {
    var attributes: EKAttributes
    init(with attributes: EKAttributes) {
        self.attributes = attributes
    }
}
