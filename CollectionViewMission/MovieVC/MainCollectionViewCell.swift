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
      
        self.bestMovieBtn.addTarget(self, action: #selector(bestMovieBtnClicked(_:)), for: .touchUpInside)
    }
    
    func configureCell(item : Movie) {
        self.mainImage.image = UIImage(named: item.imageName)
        self.mainImage.contentMode = .scaleToFill
        self.titleLabel.text = item.title
        self.rateLabel.text = "\(item.rate)점"

        
        self.bgView.backgroundColor = item.bgColor
        self.bgView.layer.cornerRadius = 12
        self.bgView.clipsToBounds = true

    }

    @objc func bestMovieBtnClicked(_ sender: UIButton) {
        
        isBestMovie.toggle()
        print("sender : \(sender.tag)")
        let btnImage = isBestMovie == true ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        
        bestMovieBtn.setImage(btnImage, for: .normal)
        
        
    }
}
