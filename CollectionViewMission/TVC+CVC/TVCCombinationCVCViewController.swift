//
//  TVCCombinationCVCViewController.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/08/02.
//

import UIKit

class TVCCombinationCVCViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let movies = MovieInfo()
    
    @IBOutlet var baseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
//        navigationController?.navigationBar.backgroundColor = .white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return movies.movie.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "첫번째 섹션"
        } else {
            return "두번째 섹션"
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return 150
        }
       
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopTableViewCell.identifier, for: indexPath) as? TopTableViewCell else { return UITableViewCell() }
            cell.contentView.backgroundColor = .yellow
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomTableViewCell.identifier, for: indexPath) as? BottomTableViewCell else { return UITableViewCell() }
            let row = movies.movie[indexPath.row]
            cell.configure(movieData: row)
          return cell
        }
       //  return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("두번째 테이블 뷰 Cell - didSelectRowAt \(indexPath)")
        
        // UIStoryboard(name: , bundle: ) - 어떤 파일에서 즉, 출발지
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // instantiateViewController - 도착지
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        let movie = movies.movie[indexPath.row]
        vc.detailData = movie
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
