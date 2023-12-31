//
//  MainCollectionViewCell.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/07/31.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var bgView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var rateLabel: UILabel!
    
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var bestMovieBtn: UIButton!
    
    var isBestMovie: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.mainImage.contentMode = .scaleToFill
        self.bgView.layer.cornerRadius = 12
        self.bgView.clipsToBounds = true
    }
    
    func configureCell(item : Movie) {
        self.mainImage.image = UIImage(named: item.imageName)
        
        self.titleLabel.text = item.title
        self.rateLabel.text = "\(item.rate)점"
        self.bgView.backgroundColor = item.bgColor
        
        if item.isBestMovie {
            bestMovieBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            bestMovieBtn.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }

}

/*
 if data.like {
     likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
 } else {
     likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
 }
 */
