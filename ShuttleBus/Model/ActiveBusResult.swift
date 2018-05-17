//
//  ActiveBusResult.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit
import ObjectMapper

class ActiveBusResult: Mappable {
    var activeBuses:[ActiveBus]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        activeBuses <- map["activebus"]
    }
    
}
