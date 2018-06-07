//
//  DetailCell.swift
//  testApp
//
//  Created by Developer on 12/5/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit
import SDWebImage
class DetailCell: UITableViewCell {
    
    var viewModel:DetailCellViewModel!{
        didSet{
            objectName.text = viewModel.mainObject.name!
            objectDetail.text = viewModel.mainObject.title!
            objectImage.sd_setImage(with: viewModel.mainObject.imageUrl!, placeholderImage: UIImage(named: "logo"))
        }
    }
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var objectImage: UIImageView!
    @IBOutlet weak var objectName: UILabel!
    @IBOutlet weak var objectDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
