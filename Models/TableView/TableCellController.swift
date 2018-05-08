//
//  TableCellController.swift
//  5.JSON_handler
//
//  Created by iosdev on 4.5.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import UIKit

class TableCellController: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var categoryName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
