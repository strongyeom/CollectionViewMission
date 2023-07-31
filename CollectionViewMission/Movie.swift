//
//  Movie.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/07/31.
//

import UIKit

struct Movie {
    var imageName: String
    var title : String
    var description: String
    var rate: Double
     var bgColor: UIColor
    

    
    init(imageName: String, title: String, description: String, rate: Double, bgColor: UIColor) {
        self.imageName = imageName
        self.title = title
        self.description = description
        self.rate = rate
        self.bgColor = bgColor
    }
}
