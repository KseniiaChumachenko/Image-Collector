//
//  Observer.swift
//  5.JSON_handler
//
//  Created by iosdev on 5.4.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import Foundation
protocol DataObserver{
    func update(change: [Category])
}
