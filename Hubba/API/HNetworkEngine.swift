//
//  HNetworkEngine.swift
//  Hubba
//
//  Created by cc on 17/1/21.
//  Copyright © 2017年 Hubba. All rights reserved.
//

import Alamofire
import SwiftyJSON

protocol HNetworkEngineProtocol {
    func post(endPoint: String, requestParams: [String: Any]?, successHandler: @escaping(_ response: JSON)->Void, failureHandler: @escaping(_ errorMessage: String)->Void)
}

class HNetworkEngine: HNetworkEngineProtocol {
    static var baseURL: String!
    
    class func config(baseURL: String) {
        HNetworkEngine.baseURL = baseURL
    }
    
    func post(endPoint: String, requestParams: [String: Any]? = nil, successHandler: @escaping(_ response: JSON)->Void, failureHandler: @escaping(_ errorMessage: String)->Void) {
        Alamofire.request(HNetworkEngine.baseURL + endPoint, method: .post, parameters: requestParams).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                successHandler(JSON(value))
            case .failure(let error):
                failureHandler(error.localizedDescription)
            }
        }
    }
}
