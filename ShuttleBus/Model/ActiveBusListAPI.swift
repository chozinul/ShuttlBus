//
//  ActiveBusListAPI.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit
import ObjectMapper

class ActiveBusListAPI: Mappable {
    var activeBusResult:ActiveBusResult?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        activeBusResult <- map["ActiveBusResult"]
    }
}
