//
//  PopUpViewController.swift
//  iTunes Search App
//
//  Created by Lasitha Siriweera on 10/4/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var lable_company: UILabel!
    @IBOutlet weak var label_name: UILabel!
    
    @IBOutlet weak var label_type: UILabel!
    
    @IBOutlet weak var label_genre: UILabel!
    var app: App!
    
    @IBOutlet weak var btn_price: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
        // Do any additional setup after loading the view.
    }
    
    func loadDetails(){
        print(app.genre)
        label_name.text = app.name
        lable_company.text = app.artist
        label_type.text = app.type
        label_genre.text = app.genre
        if app.price == 0 {
            btn_price.setTitle(app.formattedPrice, for: .normal)
        } else {
            btn_price.setTitle(String(app.price), for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeWindow(_ sender: Any) {
        dismiss(animated: true)
    }
}
