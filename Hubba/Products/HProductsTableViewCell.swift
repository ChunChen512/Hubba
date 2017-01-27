//
//  HProductsTableViewCell.swift
//  Hubba
//
//  Created by cc on 17/1/21.
//  Copyright © 2017年 Hubba. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class HProductsTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var brandName: UILabel!
    
    func setProductLabel(_ name: String) {
        productName.text = name
    }
    
    func setBrandLable(_ name: String) {
        brandName.text = name
    }
    
    func setProductPhoto(_ imageURL: URL) {
        productImage.sd_setImage(with: imageURL)
    }
}
