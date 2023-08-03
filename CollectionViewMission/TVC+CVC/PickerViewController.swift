//
//  PickerViewController.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/08/03.
//

import UIKit

class PickerViewController: UIViewController {
    
    let movies = MovieInfo()
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    @IBOutlet var loadPicker: UIPickerView!
    
    @IBOutlet var pickBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // sheetPresentationController(UISheetPresentationController): 15.0 부터 사용 가능 모달의 모양과 동작을 정의
        if let sheetPresentationController = sheetPresentationController {
            // detents : 높이 지정
            sheetPresentationController.detents = [.medium()]
            
        }
        
        
        view.addSubview(picker)
        pickBgView.addSubview(picker)
        
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: pickBgView.leadingAnchor, constant: 10),
            picker.topAnchor.constraint(equalTo: pickBgView.topAnchor, constant: 10),
            picker.trailingAnchor.constraint(equalTo: pickBgView.trailingAnchor, constant: -10),
            picker.bottomAnchor.constraint(equalTo: pickBgView.bottomAnchor, constant: -10)
        
        ])
        
        print("picker",picker)
        picker.delegate = self
        picker.dataSource = self
        
        pickBgView.layer.cornerRadius = 12
        pickBgView.clipsToBounds = true
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
