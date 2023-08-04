//
//  ViewController.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/07/31.
//

/*
 UISearchController를 사용할 때 cancel 버튼을 눌렀을때 검색에 있는 단어가 지워지는 이유?
 => 결론... 애플이 내장한 기술이라 공식문서에서 확인 할 수 없다.
 하지만 커스텀으로 cancel button에 액션을 만들 수 있음
 UISearchController는 UISearchBar 프로토콜을 채택하고 있어서
 
 extension MainViewController: UISearchBarDelegate {
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         print("cancel 버튼이 눌렸다.")
     }
 }
사용하면 됨...
 */
import UIKit

enum SearchIsResult: String {
    case equal = "equal"
    case notEqual = "notEqual"
}

class MainViewController: UICollectionViewController {
    
    var movies = MovieInfo()     
    var searchResult: [Movie] = []
    
    var searchIsResult: SearchIsResult = .notEqual
    // 현재 VC에서 표시하려면 searchResultsController: nil로 지정
    let searchController = UISearchController(searchResultsController: SearchViewController())
    
    var item: Movie?
    var searchTitle: String?
    
    var selectedBtn: Bool = false
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        settingXib()
        setCollectionViewLayout()
        settingSearchController()
        searchIsResult = .notEqual
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = .white
        collectionView.reloadData()
        
    }
    
    func settingSearchController() {
        
            searchController.searchBar.placeholder = "영화를 검색하세요"
        
            searchController.hidesNavigationBarDuringPresentation = false
            
            self.navigationItem.searchController = searchController
            self.navigationItem.title = "영화 목록"
            self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.automaticallyShowsCancelButton = true
    }

    
    @IBAction func searchBtnClicked(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }



        let nav = UINavigationController(rootViewController: vc)

        nav.modalPresentationStyle = .fullScreen

        present(nav, animated: true)
       
    }
    
    
    func settingXib() {
        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    func setCollectionViewLayout() {
         let layout = UICollectionViewFlowLayout()
         
         let spacing: CGFloat = 10
         
         let centerSpacing: CGFloat = 30
         
         let width = UIScreen.main.bounds.width - (spacing * 3) - centerSpacing
         layout.itemSize = CGSize(width: width / 2, height: width / 2)
         
         layout.minimumLineSpacing = centerSpacing
         layout.minimumInteritemSpacing = spacing
         layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
         
         collectionView.collectionViewLayout = layout
         
    }
    
    fileprivate func settingStartSearching() {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 10
        
        let centerSpacing: CGFloat = 30
        
        let _ = UIScreen.main.bounds.width - (spacing * 3) - centerSpacing
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - (spacing * 3), height: 200)
        
        layout.minimumLineSpacing = centerSpacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        collectionView.collectionViewLayout = layout
    }
 
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch searchIsResult {
        case .equal:
            print("검색 결과가 같음")
            return searchResult.count
        case .notEqual:
            return movies.movie.count
        }
    }
    
    
    // MARK: - cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
        // tag에 static으로 숫자 넣기
        cell.bestMovieBtn.tag = movies.movie[indexPath.row].exampleBtnCount
        
        switch searchIsResult {
        case .equal:
            print("검색창에 글자가 입력되고 있음 - cellForItemAt ")
            print("indexPath.row",indexPath.row)
            let searchItem = searchResult[indexPath.row]
            cell.configureCell(item: searchItem)
        case .notEqual:
            let item = movies.movie[indexPath.item]
            
            cell.configureCell(item: item)
        }
        
        
        cell.bestMovieBtn.addTarget(self, action: #selector(btnClicked(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func btnClicked(_ sender: UIButton) {
        print("VC에서 버튼 클릭 : \(sender.tag)")
        
        movies.movie[sender.tag].isBestMovie.toggle()
        
        /*
         왜 VC에서 버튼 액션을 만드냐? Cell에서 만들면 되지
         => Cell에서 만들면 Cell이 생성될때마다 액션이 만들어지기 때문에 데이터 관점에서 불필요하게 실행되는 부분이 있고, 데이터를 옮기는 작업을 할때 Cell에서 액션을 하게 되면 클로져를 사용해서 데이터를 VC컨으로 옮겨야함
         */
     
        // 현재 로직이 movies.movie에서 적용된 isBestMovie를 search를 해서 그래도 가져오는 것이기 때문에 다른 로직은 필요 없음
        collectionView.reloadData()
    }
    
    // MARK: - didSelectItemAt
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
      
        switch searchIsResult {
        case .equal:
            item = searchResult[indexPath.row]
        case .notEqual:
            item =  movies.movie[indexPath.row]
        }
        
        vc.tabPresentStyle = .home
        vc.detailData = item
   
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    // 검색을 할때마다 메서드 실행
    func updateSearchResults(for searchController: UISearchController) {
        
        searchResult.removeAll()
        print(searchController.searchBar.text ?? "")
        
        guard let searchText = searchController.searchBar.text else { return }
        
//        let searchFilterText = movies.movie.filter {
//            $0.title.contains(searchText)
//        }
        
        for item in movies.movie {
            if item.title.contains(searchText) {
                searchResult.append(item)
            }
        }
        
//        if !searchFilterText.isEmpty {
//            print("검색 결과 일치하는것이 있다면")
//            searchIsResult = .equal
//        } else {
//            print("검색 결과 일치하는것이 없다면")
//            searchIsResult = .notEqual
//        }
//
//        searchResult = searchFilterText
//
        if searchResult.isEmpty {
            searchIsResult = .notEqual
            setCollectionViewLayout()
            
        } else {
            searchIsResult = .equal
            settingStartSearching()
        }
//        switch searchIsResult {
//        case .equal:
//            settingStartSearching()
//        case .notEqual:
//            setCollectionViewLayout()
//        }
        
        print("searchResult",searchResult)
         collectionView.reloadData()
        
    }
   
}


extension MainViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel 버튼이 눌렸다.")
    }
}
