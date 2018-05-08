//
//  TableViewController.swift
//  5.JSON_handler
//
//  Created by iosdev on 4.5.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataObserver {
    
    @IBOutlet var tableView: UITableView!
    
    let queryService = QueryService()
    var category = [Category]()
    
    func update(change: [Category]) {
        category = change
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        queryService.addObserver(newObserver: self)
        queryService.startLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = category[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCells", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCells" else {return}
        if let destination = segue.destination as? CollectionViewController{
            destination.categoryId = category[(tableView.indexPathForSelectedRow?.row)!]._id
            destination.categoryName = category[(tableView.indexPathForSelectedRow?.row)!].name
        }
    }
}
