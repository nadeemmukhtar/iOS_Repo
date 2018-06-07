//
//  AppManager.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class AppManager: NSObject {
    static let sharedManager = AppManager()
    let appDelegate:AppDelegate!
    override init() {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    }
}
