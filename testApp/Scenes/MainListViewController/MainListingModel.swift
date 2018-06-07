//
//  MainListingModel.swift
//  codingTest
//
//  Created by Developer on 11/24/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import Foundation

protocol MainListingModel: class {
    func searchKeyChanged(searchKey: String)
    func fetchObjects()
    var isLoadingInProgress: Bool { get }
    var allObjects: [MainObject] { get set }
    var filteredObjects: [MainObject] { get set }
    var objectDataChangeHandler: (() -> ())? { get set }
    var objectLoadingChangeHandler: (() -> ())? { get set }
    var objectSelectionErrorHandler: ((_ title: String, _ message: String) -> ())? { get set }
}

class MainListingModelDefault: MainListingModel {
    
    var allObjects: [MainObject] = []
    var filteredObjects: [MainObject] = []
    var isLoadingInProgress = false
    var objectDataChangeHandler: (() -> ())?
    var objectLoadingChangeHandler: (() -> ())?
    var objectSelectionErrorHandler: ((_ title: String, _ message: String) -> ())?
    
    func searchKeyChanged(searchKey: String) {
        if searchKey.characters.count > 0 {
           filteredObjects = allObjects.filter { $0.name?.lowercased().contains(searchKey.lowercased()) == true }
        }
        else {
            filteredObjects.removeAll()
            filteredObjects.append(contentsOf: allObjects)
        }
        self.objectDataChangeHandler?()
    }
    
    func getSelectedObjectIndex(name:String) -> Int?{
        for mainObject in self.filteredObjects{
            if mainObject.name!.lowercased().contains(name){
                return self.filteredObjects.index(of: mainObject)
            }
        }
        return nil
    }
    
    func fetchObjects(){
        self.startLoading()
        ObjectAPIs.shared.fetchObjects { (objects:[MainObject], error:NSError?) in
            self.stopLoading()
            if error == nil {
                self.allObjects.removeAll()
                self.filteredObjects.removeAll()
                for anObject in objects{
                    self.allObjects.append(anObject)
                    self.filteredObjects.append(anObject)
                }
                self.objectDataChangeHandler?()
                
            }else{
                self.objectSelectionErrorHandler?("Error", error!.localizedDescription)
            }
        }
    }
    
    private func startLoading() {
        self.isLoadingInProgress = true
        self.objectLoadingChangeHandler?()
    }
    private func stopLoading() {
        self.isLoadingInProgress = false
        self.objectLoadingChangeHandler?()
    }
}
