//
//  DetailViewController.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class DetailViewController: QZViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var objectTableView: UITableView!
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleLabel(title: "Detail Objects")
        objectTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.objectsModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailCell
        cell.viewModel = self.viewModel.objectsModels[indexPath.row]
        return cell
    }
}
