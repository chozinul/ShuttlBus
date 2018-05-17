//
//  LibraryAPI.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ShuttleBusAPI: NSObject {
    
    static let baseURL = "https://uat-nextbus.comfortdelgro.com.sg/EventService.svc"
    
    static func GetBusStop(completion:((BusStopListAPI?)->())?) {
        
        let URL = baseURL + "/busstops"
        let parameters: Parameters = [:]
        
        Alamofire.request(URL,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .queryString),
                          headers: ["accept": "application/json"]).responseObject { (response: DataResponse<BusStopListAPI>) in
                            let busStopList = response.result.value
                            completion?(busStopList);
        }
    }
    
}
