//
//  HProductModelSpec.swift
//  Hubba
//
//  Created by cc on 17/1/23.
//  Copyright © 2017年 Hubba. All rights reserved.
//

import Quick
import Nimble
import SwiftyJSON

class HProductModelSpec: QuickSpec {
    override func spec() {
        describe("HProductModel") {
            it("Deserialize HProductModel") {
                let jsonObject: [String: Any] = [
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
                    "o": "5616b30bb19f46285e000164",
                    "cats": [
                        "housewares-and-home-accessories",
                        "housewares-and-home-accessories__outdoor-living",
                        "housewares-and-home-accessories__outdoor-living__lighting",
                        "housewares-and-home-accessories__indoor-living",
                        "housewares-and-home-accessories__indoor-living__lighting"
                    ],

                ]
                let responseJSON = JSON.init(jsonObject)
                let model = HProductModel.fromJSON(responseJSON)
                expect(model.name).to(equal("Banded Large Outdoor Fixture"))
                expect(model.brand).to(equal("Hubbardton Forge"))
                expect(model.description).to(equal("A clean, sleek design that evokes dreams of the Far East is the hallmark of our Banded Collection. True to name, two handcrafted metal bands connected by four aluminum bars drop through square metal plates to surround the glass."))
                expect(model.pictureURL).to(equal("https://hubba-node-prod.s3.amazonaws.com/products%2F5722481b97e4906403387851%2Fmedia%2Fimages%2Fea65a7bee40940932ebf%2F365894-07-G148_1.jpg"))
                expect(model.categories.count).to(equal(5))
                expect(model.categories[0]).to(equal("Housewares & Home Accessories"))
            }
            context("if JSON doesn't have enough information") {
                it("Without name") {
                    let jsonObject: [String: Any] = [
                        "_id": "5723b0474df0066661377691",
                        "slug": "hubbardton-forge-banded-large-outdoor-fixture",
                        "b": [
                            "_id": "570bd8a71fc9fbb94659668c",
                            "n": "Hubbardton Forge",
                            "bl": "//discovery-cdn-prod.hubba.com/brands/570bd8a71fc9fbb94659668c/wordmark.jpg",
                            "idn": "hubbardton-forge"
                        ],
                        "d": "A clean, sleek design that evokes dreams of the Far East is the hallmark of our Banded Collection. True to name, two handcrafted metal bands connected by four aluminum bars drop through square metal plates to surround the glass.",
                        "sp": "https://hubba-node-prod.s3.amazonaws.com/products%2F5722481b97e4906403387851%2Fmedia%2Fimages%2Fea65a7bee40940932ebf%2F365894-07-G148_1.jpg",
                        "o": "5616b30bb19f46285e000164"
                    ]
                    let responseJSON = JSON.init(jsonObject)
                    let model = HProductModel.fromJSON(responseJSON)
                    expect(model.name).to(equal(""))
                    expect(model.brand).to(equal("Hubbardton Forge"))
                    expect(model.description).to(equal("A clean, sleek design that evokes dreams of the Far East is the hallmark of our Banded Collection. True to name, two handcrafted metal bands connected by four aluminum bars drop through square metal plates to surround the glass."))
                    expect(model.pictureURL).to(equal("https://hubba-node-prod.s3.amazonaws.com/products%2F5722481b97e4906403387851%2Fmedia%2Fimages%2Fea65a7bee40940932ebf%2F365894-07-G148_1.jpg"))
                }
                it("Without brand") {
                    let jsonObject: [String: Any] = [
                        "_id": "5723b0474df0066661377691",
                        "slug": "hubbardton-forge-banded-large-outdoor-fixture",
                        "n": "Banded Large Outdoor Fixture",
                        "d": "A clean, sleek design that evokes dreams of the Far East is the hallmark of our Banded Collection. True to name, two handcrafted metal bands connected by four aluminum bars drop through square metal plates to surround the glass.",
                        "sp": "https://hubba-node-prod.s3.amazonaws.com/products%2F5722481b97e4906403387851%2Fmedia%2Fimages%2Fea65a7bee40940932ebf%2F365894-07-G148_1.jpg",
                        "o": "5616b30bb19f46285e000164"
                    ]
                    let responseJSON = JSON.init(jsonObject)
                    let model = HProductModel.fromJSON(responseJSON)
                    expect(model.name).to(equal("Banded Large Outdoor Fixture"))
                    expect(model.brand).to(equal(""))
                    expect(model.description).to(equal("A clean, sleek design that evokes dreams of the Far East is the hallmark of our Banded Collection. True to name, two handcrafted metal bands connected by four aluminum bars drop through square metal plates to surround the glass."))
                    expect(model.pictureURL).to(equal("https://hubba-node-prod.s3.amazonaws.com/products%2F5722481b97e4906403387851%2Fmedia%2Fimages%2Fea65a7bee40940932ebf%2F365894-07-G148_1.jpg"))
                }
                it("Without all info") {
                    let jsonObject: [String: Any] = [:]
                    let responseJSON = JSON.init(jsonObject)
                    let model = HProductModel.fromJSON(responseJSON)
                    expect(model.name).to(equal(""))
                    expect(model.brand).to(equal(""))
                    expect(model.description).to(equal(""))
                    expect(model.pictureURL).to(equal(""))
                    expect(model.categories.count).to(equal(0))
                }
            }
        }
    }
}
