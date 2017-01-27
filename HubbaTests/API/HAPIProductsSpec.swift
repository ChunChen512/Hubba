//
//  HAPIProductsSpec.swift
//  Hubba
//
//  Created by cc on 17/1/21.
//  Copyright © 2017年 Hubba. All rights reserved.
//

import Foundation
import SwiftyJSON
import Quick
import Nimble

class HAPIProductsSpec: QuickSpec {
    class HFakeNetworkEngine: HNetworkEngineProtocol {
        var isPostCalled = false
        var errorMsg: String!
        
        private var postResponseJSON: JSON!
        private var isCallSuccessful: Bool!
        
        init(isCallSuccessful: Bool, postResponseJSON: JSON, errorMsg: String) {
            self.isCallSuccessful = isCallSuccessful
            self.postResponseJSON = postResponseJSON
            self.errorMsg = errorMsg
        }
        
        func post(endPoint: String, requestParams: [String: Any]?, successHandler: @escaping(_ response: JSON)->Void, failureHandler: @escaping(_ errorMessage: String)->Void) {
            self.isPostCalled = true
            if self.isCallSuccessful == true {
                successHandler(self.postResponseJSON)
            } else {
                failureHandler(self.errorMsg)
            }
        }
    }
    
    let errorMsg = "404 - Not found"
    let jsonObject: [String: Any] = [
    "products": [
    "count": 197573,
    "record": [
    [
    "_id": "5723b0474df0066661377691",
    "slug": "hubbardton-forge-banded-large-outdoor-fixture",
    "n": "Banded Large Outdoor Fixture",
    "b": [
    "_id": "570bd8a71fc9fbb94659668c",
    "n": "Hubbardton Forge",
    "bl": "//discovery-cdn-prod.hubba.com/brands/570bd8a71fc9fbb94659668c/wordmark.jpg",
    "idn": "hubbardton-forge"
    ],
    "d": "A clean, sleek design that evokes dreams of the Far East is the hallmark of our Banded Collection. True to name, two handcrafted metal bands connected by four aluminum bars drop through square metal plates to surround the glass.",
    "sp": "https://hubba-node-prod.s3.amazonaws.com/products%2F5722481b97e4906403387851%2Fmedia%2Fimages%2Fea65a7bee40940932ebf%2F365894-07-G148_1.jpg",
    "o": "5616b30bb19f46285e000164"
        ]]]
    ]
    
    
    override func spec() {
        describe("HAPIProducts") {
            it("Calls sucess handler with JSON when network call succeed") {
                let productJSON = JSON.init(self.jsonObject)
                let networkEngine = HFakeNetworkEngine(isCallSuccessful: true, postResponseJSON: productJSON, errorMsg: "")
                let productAPI = HAPIProducts(networkEngine: networkEngine)
                var apiResponse: [HProductModel]? = nil
                let productModel = HProductModel.fromJSON(productJSON["products"]["record"][0])
                var isFailureHandlerCalled = false
                productAPI.getProducts(successHandler: {
                    response in
                    apiResponse = response
                }, failureHandler: {
                    _ in
                    isFailureHandlerCalled = true
                })
                expect(networkEngine.isPostCalled).to(equal(true))
                expect(isFailureHandlerCalled).to(equal(false))
                expect(apiResponse!.count).to(equal(1))
                expect(apiResponse![0].brand).to(equal(productModel.brand))
                expect(apiResponse![0].name).to(equal(productModel.name))
                expect(apiResponse![0].description).to(equal(productModel.description))
                expect(apiResponse![0].pictureURL).to(equal(productModel.pictureURL))
            }
            context("Network call failed") {
                it("Calls failure handler") {
                    let productJSON = JSON.init(self.jsonObject)
                    let networkEngine = HFakeNetworkEngine(isCallSuccessful: false, postResponseJSON: productJSON, errorMsg: self.errorMsg)
                    let productAPI = HAPIProducts(networkEngine: networkEngine)
                    var isSuccessHandlerCalled = false
                    var apiErrorMsg = ""
                    productAPI.getProducts(successHandler: {
                        _ in
                        isSuccessHandlerCalled = true
                    }, failureHandler: {
                        response in
                        apiErrorMsg = response
                    })
                    expect(networkEngine.isPostCalled).to(equal(true))
                    expect(isSuccessHandlerCalled).to(equal(false))
                    expect(apiErrorMsg).to(equal(self.errorMsg))
                }
            }
        }
    }
}
