//
//  BusStop.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit
import ObjectMapper

class BusStop: Mappable {
    var name:String?
    var caption:String?
    var latitude:Double?
    var longitude:Double?
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        caption <- map["caption"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
}
