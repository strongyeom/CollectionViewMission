//
//  BottomTableViewCell.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/08/02.
//

import UIKit

class BottomTableViewCell: UITableViewCell {
    
    static let identifier = "BottomTableViewCell"
    
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var mainTitle: UILabel!
    
    @IBOutlet var dateAndKind: UILabel!
    
    @IBOutlet var ottTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainImage.contentMode = .scaleToFill
        self.mainImage.layer.cornerRadius = 12
        self.mainImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(movieData: Movie) {
        self.contentView.backgroundColor = .yellow
        self.dateAndKind.text = "2023.08"
        self.mainImage.image = UIImage(named: movieData.imageName)

        self.mainTitle.text = movieData.title
        self.ottTitle.text = "oTT"
    }

}
