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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    struct Storyboard {
        static let appCell = "AppCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the Search Controller
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
          fetchApps()
        tableView.estimatedRowHeight = 124
        tableView.rowHeight = UITableViewAutomaticDimension
       
    }
    
    func fetchApps()
    {
        appStoreClient.fetchApps(withTerm: "Apple", inEntity: "software") { (apps) in
            self.apps = apps
            print(self.apps ?? "No data")
            
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

extension AppStoreTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        
        let searchbarText = searchController.searchBar.text!
        
       
        if searchbarText.isEmpty {
            appStoreClient.fetchApps(withTerm: "Apple", inEntity: "software") { (apps) in
                self.apps = apps
                print(self.apps ?? "No data")
                
                self.tableView.reloadData()
            }
        } else{
            appStoreClient.fetchApps(withTerm: searchbarText, inEntity: "software") { (apps) in
                self.apps = apps
                print(self.apps ?? "No data")
                
                self.tableView.reloadData()
            }
        }
        
       
    }
}
