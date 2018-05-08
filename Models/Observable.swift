//
//  Observable.swift
//  5.JSON_handler
//
//  Created by iosdev on 5.4.2018.
//  Copyright © 2018 Kseniia Chumachenko. All rights reserved.
//

import Foundation
protocol DataObservable{
    func notifyObservers(change: [Category] )
    func addObserver(newObserver: DataObserver)
}
