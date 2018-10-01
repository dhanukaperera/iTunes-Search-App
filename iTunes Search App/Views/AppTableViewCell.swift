//
//  AppTableViewCell.swift
//  iTunes Search App
//
//  Created by Dhanuka Perera on 9/30/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell {

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appDescriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var app: App! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        appNameLabel.text = app.name
        appDescriptionLabel.text = app.description
        
        if app.price == 0 {
            priceLabel.text = app.formattedPrice
        } else {
            priceLabel.text = "$\(app.price)"
        }
        
        self.artworkImageView.image = nil
        if let url = app.artworkUrl {
            let request = URLRequest(url: url)
            let networkHandler = NetworkHandler(request: request)
            
            networkHandler.downloadData(completion: { (data, response, error) in
                // WE'RE OFF THE MAIN QUEUE!!!!!!!!!
                // WE NEED TO GET BACK ON THE MAIN QUEUE
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.artworkImageView.image = UIImage(data: imageData)
                        self.artworkImageView.layer.cornerRadius = 10.0
                        self.artworkImageView.layer.masksToBounds = true
                    }
                }
            })
        }
    }
}
