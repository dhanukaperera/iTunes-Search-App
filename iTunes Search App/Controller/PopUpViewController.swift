//
//  PopUpViewController.swift
//  iTunes Search App
//
//  Created by Lasitha Siriweera on 10/4/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var label_name: UILabel!
    var app: App!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(app.name)
        label_name.text = app.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
