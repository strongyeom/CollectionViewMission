//
//  DetailViewController.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/07/31.
//

import UIKit

enum TabPresentStyle {
    case home
    case list
}

class DetailViewController: UIViewController {
    
    static let identifier = "DetailViewController"
    var detailData: Movie?
    
    var tabPresentStyle: TabPresentStyle = .home
    
    @IBOutlet var mainTitle: UILabel!
    
    @IBOutlet var rateLabel: UILabel!
    
    @IBOutlet var mainImage: UIImageView!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var bestMovieBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bestMovieBtn.addTarget(self, action: #selector(bestMovieBtnClicked(_:)), for: .touchUpInside)
        
        switch tabPresentStyle {
        case .home:
            configureDetail()
        case .list:
            configureListDetail()
        }
        
    }
    
    func configureDetail() {
        guard let detailData = detailData else { return }
        
        navigationItem.title = "영화 상세 화면"
//        navigationController?.navigationBar.tintColor = detailData.bgColor
        navigationController?.navigationBar.backgroundColor = detailData.bgColor
        mainImage.image = UIImage(named: detailData.imageName)
        mainImage.layer.cornerRadius = 12
        mainImage.clipsToBounds = true
        mainImage.contentMode = .scaleToFill
        
        mainTitle.text = "제목 : \(detailData.title)"
        mainTitle.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        
       
        rateLabel.text = "\(detailData.rate) 점"
        rateLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        rateLabel.textColor = .lightGray
        
        descriptionLabel.text = detailData.description
    }
    
    func configureListDetail() {
        guard let detailData = detailData else { return }
        
        navigationItem.title = "영화 상세 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xmarkBtnClicked(_:)))
        navigationController?.navigationBar.backgroundColor = detailData.bgColor
        mainImage.image = UIImage(named: detailData.imageName)
        mainImage.layer.cornerRadius = 12
        mainImage.clipsToBounds = true
        mainImage.contentMode = .scaleToFill
        
        mainTitle.text = "제목 : \(detailData.title)"
        mainTitle.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        
       
        rateLabel.text = "\(detailData.rate) 점"
        rateLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        rateLabel.textColor = .lightGray
        
//        descriptionLabel.text = detailData.description
    }
    
    @objc func xmarkBtnClicked(_ sender: UIBarButtonItem) {
        print("DetailViewController - xmarkBtnClicked")
        dismiss(animated: true)
    }
    
    @objc func bestMovieBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line,"- sender" )
       
        
    }

    
}
