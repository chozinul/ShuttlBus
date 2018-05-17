//
//  ShuttleCollectionViewCell.swift
//  ShuttleBus
//
//  Created by Muchamad Chozinul Amri on 17/5/18.
//  Copyright © 2018 Muchamad Chozinul Amri. All rights reserved.
//

import UIKit

class ShuttleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var arrival: UILabel!
    @IBOutlet weak var nextArrival: UILabel!
    @IBOutlet weak var rightArrow: UIImageView!
}
