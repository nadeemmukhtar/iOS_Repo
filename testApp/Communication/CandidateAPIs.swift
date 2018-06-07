//
//  ObjectAPIs.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit
import Alamofire

class ObjectAPIs: NSObject {
    static let shared = ObjectAPIs()
    func fetchObjects(completion:@escaping ([MainObject],NSError?)->Void){
        var mainObjects:[MainObject]! = []
        Alamofire.request(fetchObjectsAPI).responseJSON { response in
            if let obj = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: obj, options: .allowFragments) as? NSDictionary{
                        if let topArray = json["playlist"] as? NSDictionary {
                            mainObjects = MainObject.modelsFromDictionaryArray(array: topArray["a"] as! NSArray)
                            mainObjects.shuffle()
                            completion(mainObjects,nil)
                        }
                    }
                }catch{
                    completion(mainObjects, NSError(domain: "APIs", code: 5000, userInfo: [NSLocalizedDescriptionKey:error.localizedDescription]))
                }
            }
        }
        
    }

}
