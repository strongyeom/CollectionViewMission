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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
