//
//  ViewController.swift
//  iTunes Search App
//
//  Created by Dhanuka Perera on 9/30/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var apps: [App]?
    var appStoreClient = AppStoreClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchApps()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchApps()
    {
        appStoreClient.fetchApps(withTerm: "instagram", inEntity: "software") { (apps) in
            self.apps = apps
            print(self.apps)
        }
    }


}

