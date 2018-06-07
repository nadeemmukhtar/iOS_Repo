//
//  MainListingCell.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class MainListingCell: UICollectionViewCell {
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var objectName: UILabel!
    @IBOutlet weak var objectImage: UIImageView!
    var viewModel:MainListingCellViewModel!{
        didSet{
            viewModel.cell = self
            self.objectImage.sd_setImage(with: viewModel.mainObject.imageUrl, placeholderImage: UIImage(named: "logo"))
            self.objectName.text = viewModel.mainObject.name!
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        footerView.layer.borderColor=UIColor.lightGray.cgColor
        footerView.layer.borderWidth=1
    }
}
