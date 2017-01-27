//
//  HAPIManager.swift
//  Hubba
//
//  Created by cc on 17/1/21.
//  Copyright © 2017年 Hubba. All rights reserved.
//

class HAPIManager {
    static let sharedInstance = HAPIManager()
    private init() {
    }
    
    private func failureHandler(_ errorMessage: String) {
        print(errorMessage)
    }
    
    func getProducts(handler: @escaping(_ response: [HProductModel])->Void) {
        let apiProducts = HAPIProducts()
        apiProducts.getProducts(successHandler: {
            response in
            handler(response)
        }, failureHandler: {
            errorMessage in
            self.failureHandler(errorMessage)
        })
    }
}

