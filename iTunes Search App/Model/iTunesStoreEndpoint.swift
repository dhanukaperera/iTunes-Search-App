//
//  iTunesStoreEndpoint.swift
//  iTunes Search App
//
//  Created by Dhanuka Perera on 9/30/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import Foundation

// Ex: https://itunes.apple.com/search?term=Puzzle&limit=200&entity=software

enum iTunesStoreEndpoint {
    
    case search(term: String, entity: String)
    
    private var baseURL: String {
        return "https://itunes.apple.com/"
    }
    
    private var path: String {
        switch self {
        case .search: return "/search"
        }
    }
    
    private struct ParameterKeys {
        static let country = "country"
        static let term = "term"
        static let entity = "entity"
    }
    
    private struct DefaultValues {
        static let country = "us"
        static let term = "apple"
    }
    
    
}
