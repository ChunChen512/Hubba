//
//  HAPIProducts.swift
//  Hubba
//
//  Created by cc on 17/1/21.
//  Copyright © 2017年 Hubba. All rights reserved.
//

class HAPIProducts {
    private var networkEngine: HNetworkEngineProtocol
    
    private func getEndPoint() -> String{
        return "search/api/search"
    }
    
    init(networkEngine: HNetworkEngineProtocol? = nil) {
        self.networkEngine = networkEngine ?? HNetworkEngine()
    }
    
    func getProducts(successHandler: @escaping(_ response: [HProductModel])->Void, failureHandler: @escaping(_ errorMessage: String)->Void) {
        let endPoint = getEndPoint()
        networkEngine.post(endPoint: endPoint, requestParams: nil, successHandler: {
            response in
            var products: [HProductModel] = []
            let productsJSON = response["products"]["record"]
            for index in 0..<productsJSON.count {
                let product = HProductModel.fromJSON(productsJSON[index])
                products.append(product)
            }
            successHandler(products)
        }, failureHandler: {
            errorMessage in
            failureHandler(errorMessage)
        })
    }
}

