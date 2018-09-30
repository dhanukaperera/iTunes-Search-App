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
    
    // Setting up the base URL of iTunes endpoint
    private var baseURL: String {
        return "https://itunes.apple.com/"
    }
    
    // adding the search? path to endpoint
    private var path: String {
        switch self {
        case .search: return "/search"
        }
    }
    
    // Defining the paremeters of the endpoint
    private struct ParameterKeys {
        static let country = "country"
        static let term = "term"
        static let entity = "entity"
    }
    
    // Setting defult values for the endpoint parameters.
    private struct DefaultValues {
        static let country = "us"
        static let term = "Puzzle"
    }
    
    private var parameters: [String : Any] {
        switch self {
        case .search(let term, let entity):
            let parameters: [String : Any] = [
                ParameterKeys.term : term,
                ParameterKeys.country : DefaultValues.country,
                ParameterKeys.entity : entity
            ]
            
            return parameters
        }
    }
    
    // adding parametermeters to the qeury component.
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
    
    // Buliding the full endpoint URL
    var request: URLRequest {
        var components = URLComponents(string: baseURL)!
        components.path = path
        components.queryItems = queryComponents
        
        let url = components.url!
        return URLRequest(url: url)
    }
    
    
}
