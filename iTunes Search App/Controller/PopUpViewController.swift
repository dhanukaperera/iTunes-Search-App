//
//  PopUpViewController.swift
//  iTunes Search App
//
//  Created by Lasitha Siriweera on 10/4/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    var app: App!
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var lable_company: UILabel!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_genre: UILabel!
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var btn_price: UIButton!
    @IBOutlet weak var btn_close: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    func setLayout(){
        popupView.layer.cornerRadius = 20
        btn_price.layer.borderWidth = 2
        btn_price.layer.cornerRadius = 6
        btn_price.layer.borderColor = UIColor(red: 84/225, green: 149/255, blue: 251/255, alpha: 1).cgColor
        btn_close.layer.cornerRadius = 16
    }
    
    func loadDetails(){
        print(app.genre)
        label_name.text = app.name
        lable_company.text = app.artist
        label_type.text = app.type.capitalized
        label_genre.text = app.genre
        if app.price == 0 {
            btn_price.setTitle(app.formattedPrice, for: .normal)
        } else {
            btn_price.setTitle(String(app.price), for: .normal)
        }
        
        self.appIcon.image = nil
        if let url = app.artworkUrl {
            let request = URLRequest(url: url)
            let networkHandler = NetworkHandler(request: request)
            
            networkHandler.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.appIcon.image = UIImage(data: imageData)
                        self.appIcon.layer.cornerRadius = 10.0
                        self.appIcon.layer.masksToBounds = true
                    }
                }
            })
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
