//
//  MainListingViewController.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainListingViewController: QZViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var viewModel: MainListingViewModel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var searchbar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = MainListingModelDefault()
        self.viewModel = MainListingViewModel(dataModel: model)
        self.viewModel.delegate = self
        viewModel.fetchObjects()
        self.setTitleLabel(title: "BBC Radio")
        self.mainCollectionView.allowsMultipleSelection = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - CollecitonView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getFilteredObjects().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainListingCell", for: indexPath) as! MainListingCell
        cell.viewModel = self.viewModel.mainListingCellModels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var divisor:CGFloat = 2.0
        let collVuWidth = collectionView.frame.size.width
        var width = (collVuWidth-11)/divisor
        while width > cellMinWidth {
            divisor += 1.0
            width = (collVuWidth-(((divisor-1)*10)+1))/divisor
        }
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let objectModel = self.viewModel.mainListingCellModels[indexPath.row]
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailObjectViewController") as? DetailViewController {
            let models: [DetailCellViewModel] = [DetailCellViewModel(mainObject: objectModel.mainObject)]
            viewController.viewModel.objectsModels = models
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    //MARK: - showAlert
    internal func showMessage(title:String,message:String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension MainListingViewController: MainListingViewModelDelegate {
    func startLoading() {
        let p = MBProgressHUD.showAdded(to: AppManager.sharedManager.appDelegate.window!, animated: true)
        p.detailsLabel.text = "Fetching BBC Radio Data..."
    }
    
    func stopedLoading() {
        MBProgressHUD.hideAllHUDs(for: AppManager.sharedManager.appDelegate.window!, animated: true)
    }
    
    func reloadedData() {
        self.mainCollectionView.reloadData()
    }
    
    func showAlertMessage(tittle: String, message: String) {
        showMessage(title: tittle, message: message)
    }
}

extension MainListingViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchKeyChanged(searchKey: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

}
