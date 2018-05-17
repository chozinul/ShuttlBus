//
//  ShuttleServiceResult.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit
import ObjectMapper

class ShuttleServiceResult: Mappable {
    var caption:String?
    var name:String?
    var shuttles:[Shuttle]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        shuttles <- map["shuttles"]
        caption <- map["caption"]
        name <- map["name"]
    }
    
}
