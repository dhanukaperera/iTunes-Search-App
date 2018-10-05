//
//  App.swift
//  iTunes Search App
//
//  Created by Dhanuka Perera on 9/30/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import Foundation

struct App {
    
    var name: String
    var price: Double
    var description: String
    var formattedPrice: String
    var artworkUrl: URL?
    var itunesUrl: URL?
    var genre: String
    var artist: String
    var type: String
    
    private struct APIKeys {
        static let name = "trackName"
        static let artworkURL = "artworkUrl512"
        static let description = "description"
        static let formattedPrice = "formattedPrice"
        static let price = "price"
        static let genre = "primaryGenreName"
        static let artist = "artistName"
        static let type = "kind"
    }
    
    init?(dictionary: [String : Any])
    {
        guard let name = dictionary[APIKeys.name] as? String,
            let artworkURLString = dictionary[APIKeys.artworkURL] as? String,
            let description = dictionary[APIKeys.description] as? String,
            let formattedPrice = dictionary[APIKeys.formattedPrice] as? String,
            let price = dictionary[APIKeys.price] as? Double,
            let genre = dictionary[APIKeys.genre] as? String,
            let artist = dictionary[APIKeys.artist] as? String,
            let type = dictionary[APIKeys.type] as? String
        else {
                return nil
        }
        
        self.name = name
        self.artworkUrl = URL(string: artworkURLString)
        self.description = description
        self.formattedPrice = formattedPrice
        self.price = price
        self.genre = genre
        self.artist = artist
        self.type = type
    }
}
