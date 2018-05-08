//
//  GetImages.swift
//  5.JSON_handler
//
//  Created by iosdev on 4.5.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import Foundation
    
func loadImages(path: String){
    let mainQueue = DispatchQueue.main
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "imagecollector.herokuapp.com"
    urlComponents.path = "/cat/" + path
    guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    var headers = request.allHTTPHeaderFields ?? [:]
    headers["Content-Type"] = "application/json"
    request.allHTTPHeaderFields = headers
    
    
    // Create and run a URLSession data task with our JSON encoded POST request
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        guard responseError == nil else {
            return
        }
        
        // APIs respond
        guard let data = responseData else {return}
        do{
            let resived = try JSONDecoder().decode(Images.self, from: data)
            var images = resived.image
            print(images)
            mainQueue.async {
               // self.notifyObservers(change: categories)
            }
        } catch {
            print("no readable data received in response")
        }
        
        
    }
    task.resume()
}

