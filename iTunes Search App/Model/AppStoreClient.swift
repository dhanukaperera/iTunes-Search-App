//
//  AppStoreClient.swift
//  iTunes Search App
//
//  Created by Dhanuka Perera on 9/30/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import Foundation

struct AppStoreClient
{
    func fetchApps(withTerm term: String, inEntity entity: String, completion: @escaping ([App]?) -> Void)
    {
        // 1. endpoint
        let searchEndpoint = iTunesStoreEndpoint.search(term: term, entity: entity)
        let searchUrlRequest = searchEndpoint.request
        
        // 2. network processor
        let networkHandler = NetworkHandler(request: searchUrlRequest)
        networkHandler.downloadJSON { (jsonResponse, httpResponse, error) in
            // THIS IS NOW OFF-THE-MAIN-THREAD!!!!
            // NOW, WE NEED TO GET BACK TO THE MAIN THREAD
            
            DispatchQueue.main.async {
                // 3. get the array of app dictionaries
                guard let json = jsonResponse,
                    let resultDictionaries = json["results"] as? [[String : Any]] else {
                        completion(nil)
                        return
                }
                
                // 4. create an array of apps
                let apps = resultDictionaries.flatMap({ appDictionary in
                    return App(dictionary: appDictionary)
                })
                
                // 5. call completion
                completion(apps)
            }
        }
    }
}
