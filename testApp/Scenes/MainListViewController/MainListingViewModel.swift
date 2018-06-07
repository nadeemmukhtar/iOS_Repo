//
//  MainListingViewModel.swift
//  codingTest
//
//  Created by Developer on 11/24/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import Foundation

protocol MainListingViewModelDelegate: class {
    
    func startLoading()
    func stopedLoading()
    func reloadedData()
    func showAlertMessage(tittle: String, message: String)
}

class MainListingViewModel {
    
    weak var delegate: MainListingViewModelDelegate?
    var mainListingCellModels:[MainListingCellViewModel] = []
    let dataModel: MainListingModel
    init(dataModel: MainListingModel) {
        self.dataModel = dataModel
        self.dataModel.objectLoadingChangeHandler = { [weak self] in
            self?.notifyLoadingChanged()
        }
        self.dataModel.objectDataChangeHandler = { [weak self] in
            self?.notifyNewDataChanged()
        }
        
        self.dataModel.objectSelectionErrorHandler = { (tittle: String, message: String) in
            self.notifyShowMessage(tittle: tittle, message: message)
        }
    }
    
    func getAllObjects() -> [MainObject] {
        return dataModel.allObjects
    }
    
    func getFilteredObjects() -> [MainObject] {
        return dataModel.filteredObjects
    }
    
    func fetchObjects() {
        dataModel.fetchObjects()
    }
    
    //MARK: - Actions
    func updateOrders(){
        
        self.delegate?.reloadedData()
    }
    
    func getSelectedObjectIndex(name:String)->Int?{
        for mainObject in self.dataModel.filteredObjects{
            if mainObject.name!.lowercased().contains(name){
                return self.dataModel.filteredObjects.index(of: mainObject)
            }
        }
        return nil
    }
    
    func searchKeyChanged(searchKey: String) {
        self.dataModel.searchKeyChanged(searchKey: searchKey)
    }
    
    // MARK: Notifying
    
    private func notifyLoadingChanged() {
        if dataModel.isLoadingInProgress {
            self.delegate?.startLoading()
        }
        else {
            self.delegate?.stopedLoading()
        }
        
    }
    
     private func notifyNewDataChanged() {
        self.mainListingCellModels.removeAll()
        for mainObjecet in self.dataModel.filteredObjects{
            self.mainListingCellModels.append(MainListingCellViewModel(mainObject: mainObjecet))
        }
        self.delegate?.reloadedData()
    }
    
    private func notifyShowMessage(tittle: String, message: String) {
        self.delegate?.showAlertMessage(tittle: tittle, message: message)
    }
}
