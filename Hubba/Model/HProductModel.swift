//
//  HProductModel.swift
//  Hubba
//
//  Created by cc on 17/1/21.
//  Copyright © 2017年 Hubba. All rights reserved.
//

import SwiftyJSON

class HProductModel {
    var name: String!
    var description: String!
    var pictureURL: String!
    var brand: String!
    var categories = [String]()
    
    class func fromJSON(_ product: JSON) -> HProductModel{
        let instance = HProductModel()
        instance.name = product["n"].stringValue
        instance.description = product["d"].stringValue
        instance.pictureURL = product["sp"].stringValue
        instance.brand = product["b"]["n"].stringValue
        
        for category in product["cats"].arrayValue {
            var categoryStr = category.stringValue
            categoryStr = categoryStr.replacingOccurrences(of: "-and-", with: " & ")
            categoryStr = categoryStr.replacingOccurrences(of: "-", with: " ")
            categoryStr = categoryStr.replacingOccurrences(of: "__", with: " > ")
            instance.categories.append(categoryStr.localizedCapitalized)
        }
        
        return instance
    }
}
