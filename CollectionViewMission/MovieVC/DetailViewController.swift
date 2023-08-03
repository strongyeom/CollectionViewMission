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
    
    @IBOutlet var textView: UITextView!
    
    var placeHolder: String = "두번째 탭에서 넘어온 홀더에요."
    
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
        descriptionLabel.isHidden = false
        textView.isHidden = true
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
        
        descriptionLabel.isHidden = true
        textView.isHidden = false
        configureTextView()
    }
    
    func configureTextView() {
        textView.delegate = self
        textView.text = placeHolder
        textView.textColor = .lightGray
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.red.cgColor
    }
    
    @objc func xmarkBtnClicked(_ sender: UIBarButtonItem) {
        print("DetailViewController - xmarkBtnClicked")
        dismiss(animated: true)
    }
    
    @objc func bestMovieBtnClicked(_ sender: UIButton) {
        print(#fileID, #function, #line,"- sender" )
       
        
    }
}

extension DetailViewController: UITextViewDelegate {
    // 커서가 시작 될때
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("커서 시작 ")
        if textView.text == placeHolder {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    
    // 커서가 없어 졌을때
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolder
            textView.textColor = UIColor.lightGray
        }
    }
}
