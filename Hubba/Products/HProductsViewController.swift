//
//  HProductsViewController.swift
//  Hubba
//
//  Created by cc on 17/1/21.
//  Copyright © 2017年 Hubba. All rights reserved.
//

import UIKit

fileprivate let CellIdentifier = "HProductsTableViewCell"

class HProductsViewController: UITableViewController {
    var products = [HProductModel]()
    let tableCellHeight: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = tableCellHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.getProducts()
    }
}

//MARK: - Data process
private extension HProductsViewController {
    func getProducts() {
        let apiManager: HAPIManager = HAPIManager.sharedInstance
        apiManager.getProducts() {
            [weak self] response in
            if (self != nil) {
                self!.products += response
                self!.tableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension HProductsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier) as! HProductsTableViewCell
        cell.setProductLabel(products[indexPath.row].name)
        cell.setBrandLable(products[indexPath.row].brand)
        cell.setProductPhoto(URL(string: products[indexPath.row].pictureURL)!)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HProductsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let productDetailViewController = segue.destination as! HProductDetailViewController
        if let selectedProductCell = sender as? HProductsTableViewCell {
            let indexPath = tableView.indexPath(for: selectedProductCell)!
            productDetailViewController.product = products[indexPath.row]
        }
    }
}
