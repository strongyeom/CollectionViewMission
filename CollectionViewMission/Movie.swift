//
//  Movie.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/07/31.
//

import UIKit

// class 로 바꾸면 참조 타입으로 detailVC에서 값을 바꿨을때 MainVC에서 reload만 해줘도 star의 image를 바꿀 수 있음 
struct Movie {
    
    static var btnTag: Int = 0
    
    
    var imageName: String
    var title : String
    var description: String
    var rate: Double
    var bgColor: UIColor
    var isBestMovie: Bool
    var exampleBtnCount: Int = btnTag
    
    init(imageName: String, title: String, description: String, rate: Double, bgColor: UIColor, isBestMovie: Bool) {
        self.imageName = imageName
        self.title = title
        self.description = description
        self.rate = rate
        self.bgColor = bgColor
        self.isBestMovie = isBestMovie
        Movie.btnTag += 1
    }
}
