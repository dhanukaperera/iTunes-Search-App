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
    var app: App?
    var myIndex=0;
    
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
        
        fetchApps(searchTerm: "Apple")
        tableView.estimatedRowHeight = 124
        tableView.rowHeight = UITableViewAutomaticDimension
       
    }
    
    func fetchApps(searchTerm:String)
    {
        appStoreClient.fetchApps(withTerm: searchTerm, inEntity: "software") { (apps) in
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        app = apps![indexPath.row]
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue1"){
           //let cell = sender as! AppStoreClient
            let vc = segue.destination as! PopUpViewController
            vc.app = app
        }
    }
}


extension AppStoreTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {

        let searchbarText = searchController.searchBar.text!
        
        if searchbarText.isEmpty {
            fetchApps(searchTerm: "Apple")
        } else {
            fetchApps(searchTerm: searchbarText)
        }
        
    }
}
