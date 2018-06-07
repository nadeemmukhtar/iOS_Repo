//
//  MainObject.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 test. All rights reserved.
//

import UIKit

class MainObject: NSObject {
    var name: String?
    var imageUrl: URL?
    var title: String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [MainObject] {
        var models:[MainObject] = []
        for item in array
        {
            models.append(MainObject(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        name = dictionary["artist"] as? String
        title = dictionary["title"] as? String
        if let img = dictionary["image"] as? String {
            imageUrl = URL(string: img)
        }
    }
}
