//
//  MainListingCellViewModel.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class MainListingCellViewModel: NSObject {
    var mainObject:MainObject!
    
    var cell:MainListingCell!
    init(mainObject:MainObject) {
        self.mainObject = mainObject
    }
}
