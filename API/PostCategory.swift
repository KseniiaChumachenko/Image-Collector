//
//  PostCategory.swift
//  5.JSON_handler
//
//  Created by iosdev on 2.5.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import Foundation
struct Post: Codable{
    let name: String?
}

func submitPostCategory(post: Post, path: String, completion:((Error?) -> Void)?) {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "imagecollector.herokuapp.com"
    urlComponents.path = path
    guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"
    request.allHTTPHeaderFields = headers
    
    let encoder = JSONEncoder()
    do {
        let jsonData = try encoder.encode(post)
        request.httpBody = jsonData
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
    } catch {
        completion?(error)
    }
    
    // Create and run a URLSession data task with our JSON encoded POST request
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        guard responseError == nil else {
            completion?(responseError!)
            return
        }
        
        // APIs respond
        if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
            print("response: ", utf8Representation)
        } else {
            print("no readable data received in response")
        }
    }
    task.resume()
}
