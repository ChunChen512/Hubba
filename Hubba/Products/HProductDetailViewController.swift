//
//  HProductDetailViewController.swift
//  Hubba
//
//  Created by cc on 17/1/21.
//  Copyright © 2017年 Hubba. All rights reserved.
//

import Foundation
import UIKit
import FBSDKShareKit

fileprivate let CellIdentifier = "HProductTableViewCell"

fileprivate enum HProductsTableViewCellTag: Int {
    case imageView = 1
    case nameView
    case brandView
    case shareButton
}

class HProductDetailViewController: UITableViewController {
    var product: HProductModel? = nil
    var hasCategories = false
    let tableCellHeight: CGFloat = 300
    let sectionHeaderHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (product?.categories.count)! > 0 {
            self.hasCategories = true
        }
        self.tableView.estimatedRowHeight = tableCellHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
}

//MARK: - TableView DataSource
extension HProductDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return (product?.categories.count)! + 1
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return hasCategories ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "HProductTitleCell")!
                setupTitle(cell)
            case 1:
                cell = tableView.dequeueReusableCell(withIdentifier: "HProductCustomCell")!
                let description = cell.contentView.viewWithTag(5) as! UILabel
                description.text = product?.description
            default:
                print("error")
            }
        case 1:
            if hasCategories {
                switch indexPath.row {
                case 0:
                    cell = tableView.dequeueReusableCell(withIdentifier: "HProductCategoriesTitleCell")!
                default:
                    cell = tableView.dequeueReusableCell(withIdentifier: "HProductCustomCell")!
                    let category = cell.contentView.viewWithTag(5) as! UILabel
                    category.text = product?.categories[indexPath.row-1]
                }
                
            }
        default:
            print("error")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat
        switch section {
        case 0:
            height = CGFloat.leastNonzeroMagnitude
        default:
            height = sectionHeaderHeight
        }
        return height
    }
}

//MARK: - View Minpulate
extension HProductDetailViewController {
    fileprivate func getCellSubviewWithTag(_ cell: UITableViewCell, tag: HProductsTableViewCellTag) -> UIView? {
        return cell.contentView.viewWithTag(tag.rawValue)
    }
    
    func setupTitle(_ cell: UITableViewCell) {
        let imageView = getCellSubviewWithTag(cell, tag: .imageView) as? UIImageView
        imageView?.sd_setImage(with: URL(string: (product?.pictureURL)!))
        
        let name = getCellSubviewWithTag(cell, tag: .nameView) as? UILabel
        name?.text = product?.name
        
        let brand = getCellSubviewWithTag(cell, tag: .brandView) as? UILabel
        brand?.text = product?.brand
        
        guard  let button = getCellSubviewWithTag(cell, tag: .shareButton) as? FBSDKShareButton else {
            return
        }
        setupShareButton(button, image: imageView?.image ?? UIImage())
    }
    
    func setupShareButton(_ button: FBSDKShareButton, image: UIImage) {
        let photo = FBSDKSharePhoto()
        photo.image = image
        photo.isUserGenerated = true
        let content = FBSDKSharePhotoContent()
        content.photos = [photo]
        button.shareContent = content
    }
}
