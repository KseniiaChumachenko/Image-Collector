//
//  CollectionViewController.swift
//  5.JSON_handler
//
//  Created by iosdev on 4.5.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadFrom(url: url, contentMode: mode)
    }
}

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var categoryId: String = ""
    var categoryName: String = ""
    var images = Images.self
    var posts = [Posts]()
    var checkPost = [Posts]()
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar.topItem?.title = categoryName
        
        collectionView.dataSource = self
        loadImages(path: categoryId)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CollectionViewCell
        cell.imageView.contentMode = .scaleAspectFill
        
        let defaultLink = "https://imagecollector.herokuapp.com/"
        let completeLink = defaultLink + posts[indexPath.row].image
        print(completeLink)
        
        cell.imageView.downloadedFrom(link: completeLink)
        return cell
    }
    
    func loadImages(path: String){
        let mainQueue = DispatchQueue.main
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "imagecollector.herokuapp.com"
        urlComponents.path = "/imagePosts/cat/" + path
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        print(url)
        
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
                self.posts = resived.imagePosts
                //try to do for loop to check images
                //if(self.[posts].category === categoryId) {
                 //   self.checkPost = self.posts
               // }
               // self.posts = resived.imagePosts
                mainQueue.async {
                   self.collectionView.reloadData()
                }
            } catch {
                print("no readable data received in response")
            }
            
        }
        task.resume()
    }

}
