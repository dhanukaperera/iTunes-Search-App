//
//  AppStoreTableViewController.swift
//  iTunes Search App
//
//  Created by Dhanuka Perera on 9/30/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import UIKit

class AppStoreTableViewController: UITableViewController {

    var apps: [App]?
    var appStoreClient = AppStoreClient()
    
    struct Storyboard {
        static let appCell = "AppCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          fetchApps()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func fetchApps()
    {
        appStoreClient.fetchApps(withTerm: "Facebook", inEntity: "software") { (apps) in
            self.apps = apps
            print(self.apps)
            self.tableView.reloadData()
        }
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let apps = apps {
            return apps.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.appCell, for: indexPath) as! AppTableViewCell
        
        cell.app = apps?[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}
