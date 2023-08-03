//
//  TVCCombinationCVCViewController.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/08/02.
//

/*
 메인 테이블 뷰 VC 에서 데이터를  Cell -> CollectionView -> CollectionViewCell로 옮기는 방법은 ?
 */

import UIKit

enum SectionType: Int, CaseIterable {
    case top
    case bottom
}

class TVCCombinationCVCViewController: UIViewController {
    
    let movies = MovieInfo()
    var sectionType: SectionType = .top
    
    var searchBar = UISearchBar()
    
  
    var searchedData: [Movie]?
    
   
    
    @IBOutlet var baseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        settingTableView()
        navigationItem.titleView = searchBar
        
    
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "피커", style: .plain, target: self, action: #selector(leftbarBtnClicked(_:)))
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        
    }
    
    @objc func leftbarBtnClicked(_ sender: UIBarButtonItem) {
        print("바 버튼 클릭")
       
        let storyBoard = UIStoryboard(name: "TVCCombinationCVC", bundle: nil)
        
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "PickerViewController") as? PickerViewController else { return }

        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
    
    func settingTableView() {
        baseTableView.dataSource = self
        baseTableView.delegate = self
        // baseTableView.rowHeight = 200
        baseTableView.separatorStyle = .none
        // tableView.style을 plain이 아닌걸로 했을때 sectionHeader 짤리는 현상 있음..
        // 해결책으로 tableView.sectionHeaderTopPadding에 간격을 설정 할 수 있음
        baseTableView.sectionHeaderTopPadding = 6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .white
    }
    
}


// MARK: - Delegate
extension TVCCombinationCVCViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        let section = SectionType(rawValue: indexPath.section)
        
        switch section {
        case .top:
            return 200
        case .bottom:
            return 150
        default:
            return 0
        }
       
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("두번째 테이블 뷰 Cell - didSelectRowAt \(indexPath)")
        
        // UIStoryboard(name: , bundle: ) - 어떤 파일에서 즉, 출발지
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // instantiateViewController - 도착지
        guard let vc = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        let movie = movies.movie[indexPath.row]
        
        vc.detailData = movie
        vc.tabPresentStyle = .list
        
        let nav = UINavigationController(rootViewController: vc)
        
       
      
        nav.modalPresentationStyle = .fullScreen
        
        
        present(nav, animated: true)
    }
    
}


// MARK: - DataSource
extension TVCCombinationCVCViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = SectionType(rawValue: section)
        
        switch section {
        case .top:
            return 1
        case .bottom:
            return movies.movie.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let section = SectionType(rawValue: indexPath.section)
        
        
        switch section {
        case .top:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopTableViewCell.identifier, for: indexPath) as? TopTableViewCell else { return UITableViewCell() }
            print("cellForRowAt - searchedData \(searchedData)")
            cell.searchMovies = searchedData
            cell.contentView.backgroundColor = .yellow
            return cell
        case .bottom:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomTableViewCell.identifier, for: indexPath) as? BottomTableViewCell else { return UITableViewCell() }
            let row = movies.movie[indexPath.row]
            cell.configure(movieData: row)
          return cell
        default:
            return UITableViewCell()
        }
        
        
    
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let section = SectionType(rawValue: section)
        
        switch section {
        case .top:
            return "최근 검색 기록"
        case .bottom:
            return "무비 리스트"
        default:
            return ""
        }
    }
    
}

extension TVCCombinationCVCViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        // 검색 필터를 했을때 결과로 나온 데이터를 어떻게 TopCell에 있는 곳을 전달 할 수 있을까 ?
        
        searchedData = movies.movie.filter { $0.title == searchBar.text! }
        
        print("searchedData",searchedData)
        
        print(#function)
        baseTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
    
}

