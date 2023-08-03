//
//  PickerViewController.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/08/03.
//

import UIKit

class PickerViewController: UIViewController {
    
    let movies = MovieInfo()
    
    //let picker = UIPickerView()

    @IBOutlet var loadPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            
        }
        
        loadPicker.delegate = self
        loadPicker.dataSource = self
        
        self.view.backgroundColor = .clear
    }
}

extension PickerViewController: UIPickerViewDelegate {
    
}


extension PickerViewController: UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        print(#function)
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print(#function)
        return movies.movie.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(#function)
        return movies.movie[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function)
        
    }
    
}
