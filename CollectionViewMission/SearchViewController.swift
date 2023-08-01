//
//  SearchViewController.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "검색 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(deleteBtnClicked(_:)))
    }

    @objc func deleteBtnClicked(_ sender: UIBarButtonItem) {
        
        print(#fileID, #function, #line,"- <#comment#>" )
        dismiss(animated: true)
    }
 
}

