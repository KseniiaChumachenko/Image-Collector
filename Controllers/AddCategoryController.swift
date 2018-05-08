//
//  AddCategoryController.swift
//  5.JSON_handler
//
//  Created by iosdev on 4.5.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import UIKit

class AddCategoryController: UIViewController, UITextFieldDelegate {

    let queryService = QueryService()
    var input: String = ""
    
    @IBOutlet weak var nameNewCategory: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextField()
    }

    @IBAction func sendNewCategory(_ sender: UIButton) {
        input = nameNewCategory.text!
        let post = Post(name: input)
        submitPostCategory(post: post, path: "/categories") { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        performSegue(withIdentifier: "returnToTable", sender: self)
    }
    
    func initTextField(){
        nameNewCategory.delegate = self
        nameNewCategory.keyboardType = UIKeyboardType.alphabet
    }
}
