//
//  ViewController.swift
//  5.JSON_handler
//
//  Created by iosdev on 23.3.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataObserver, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate  {
    

    let queryService = QueryService()
    var category = [Category]()
    var input: String = ""
   
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var newCategoryInput: UITextField!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    
    func update(change: [Category]) {
        category = change
        pickerView.reloadAllComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextField()
        
        queryService.addObserver(newObserver: self)
        queryService.startLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    func pickerView(_
        pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int
        ) -> String? {
        return category[row].name
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected = category[row].name
        categoryLabel.text = selected
    }
    
    func initTextField(){
        newCategoryInput.delegate = self
        newCategoryInput.keyboardType = UIKeyboardType.alphabet
        }
    
    @IBAction func sendNewCategory(_ sender: Any) {
        input = newCategoryInput.text!
        let post = Post(name: input)
        submitPostCategory(post: post, path: "/categories") { (error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
    }
        queryService.startLoad()
    }

}
extension ViewController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
