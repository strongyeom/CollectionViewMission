//
//  TopCollectionViewCell.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/08/02.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TopCollectionViewCell"
    @IBOutlet var mainImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainImage.layer.cornerRadius = 12
        self.mainImage.clipsToBounds = true
    }
}
