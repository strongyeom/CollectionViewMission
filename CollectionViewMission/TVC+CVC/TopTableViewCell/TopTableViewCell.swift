//
//  TopTableViewCell.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/08/02.
//

import UIKit

class TopTableViewCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource {

    static let identifier = "TopTableViewCell"
    @IBOutlet var topcollectionView: UICollectionView!
    
    let movies = MovieInfo()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topcollectionView.delegate = self
        topcollectionView.dataSource = self
        configureCollectionViewLayout()
        topcollectionView.backgroundColor = .red
    }
    
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 170)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        topcollectionView.collectionViewLayout = layout
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifier, for: indexPath) as? TopCollectionViewCell else { return UICollectionViewCell() }
        let item = movies.movie[indexPath.row]
        cell.mainImage.image = UIImage(named: item.imageName)
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("첫번째 테이블 뷰 Cell - didSelectItemAt \(indexPath)")
    }
}
