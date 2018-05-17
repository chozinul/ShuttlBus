//
//  Shuttle.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit
import ObjectMapper

class Shuttle: Mappable {
    var arrivalTime:String?
    var name:String?
    var nextArrivalTime:String?
    var nextPassengers:String?
    var passengers:String?
    var arrivalTimeVehPlate:String?
    var nextArrivalTimeVehPlate:String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        arrivalTime <- map["arrivalTime"]
        name <- map["name"]
        nextArrivalTime <- map["nextArrivalTime"]
        nextPassengers <- map["nextPassengers"]
        passengers <- map["passengers"]
        arrivalTimeVehPlate <- map["arrivalTime_veh_plate"]
        nextArrivalTimeVehPlate <- map["nextArrivalTime_veh_plate"]
    }
    
}
