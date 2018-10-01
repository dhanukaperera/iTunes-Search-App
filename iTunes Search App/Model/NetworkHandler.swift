//
//  NetworkHandler.swift
//  iTunes Search App
//
//  Created by Dhanuka Perera on 9/30/18.
//  Copyright © 2018 Dhanuka Perera. All rights reserved.
//

import Foundation

public let NetworkingErrorDomain = "\(Bundle.main.bundleIdentifier!).NetworkingError"
public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20

class NetworkHandler {
    
    let request: URLRequest
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    init(request: URLRequest) {
        self.request = request
    }
    
    typealias JSON = [String : Any]
    typealias JSONHandler = (JSON?, HTTPURLResponse?, Error?) -> Void
    typealias DataHandler = (Data?, HTTPURLResponse?, Error?) -> Void
    
    func downloadJSON(completion: @escaping JSONHandler)
    {
        let dataTask = session.dataTask(with: self.request) { (data, response, error) in
            // OFF THE MAIN THREAD
            // Error: missing http response
            guard let httpResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString("Missing HTTP Response", comment: "")]
                let error = NSError(domain: NetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error as Error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, httpResponse, error)
                }
            } else {
                switch httpResponse.statusCode {
                case 200:
                    // OK parse JSON into Foundation objects (array, dictionary..)
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                        completion(json, httpResponse, nil)
                    } catch let error as NSError {
                        completion(nil, httpResponse, error)
                    }
                default:
                    print("Received HTTP response code: \(httpResponse.statusCode) - was not handled in NetworkProcessing.swift")
                }
            }
        }
        
        dataTask.resume()
    }
    
    func downloadData(completion: @escaping DataHandler)
    {
        let dataTask = session.dataTask(with: self.request) { (data, response, error) in
            // OFF THE MAIN THREAD
            // Error: missing http response
            guard let httpResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString("Missing HTTP Response", comment: "")]
                let error = NSError(domain: NetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error as Error)
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, httpResponse, error)
                }
            } else {
                switch httpResponse.statusCode {
                case 200:
                    completion(data, httpResponse, nil)
                default:
                    print("Received HTTP response code: \(httpResponse.statusCode) - was not handled in NetworkProcessing.swift")
                }
            }
        }
        
        dataTask.resume()
    }
}
