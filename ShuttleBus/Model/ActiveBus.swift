//
//  ActiveBus.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit
import ObjectMapper

class ActiveBus: Mappable {
    var vehPlace:String?
    var lat:Double?
    var lng:Double?
    var speed:Int?
    var direction:Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        vehPlace <- map["vehplate"]
        lat <- map["lat"]
        lng <- map["lng"]
        speed <- map["speed"]
        direction <- map["direction"]
    }
    
}
