//
//  ViewController.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/07/31.
//

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
    let searchController = UISearchController(searchResultsController: nil)
    
    var item: Movie?
    
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
            self.navigationItem.title = "Search"
            self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        
        self.searchController.searchBar.delegate = self

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
        
        
        
        return cell
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
        
        
        print("didSelectItemAt: \(item)")
        vc.detailData = item
   
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
        
        guard let searchText = searchController.searchBar.text else { return }
        let searchFilterText = movies.movie.filter {
            $0.title.contains(searchText)
        }
        
        if !searchFilterText.isEmpty {
            print("검색 결과 일치하는것이 있다면")
            searchIsResult = .equal
        } else {
            print("검색 결과 일치하는것이 없다면")
            searchIsResult = .notEqual
        }
        
        searchResult = searchFilterText
        
        switch searchIsResult {
        case .equal:
            settingStartSearching()
        case .notEqual:
            setCollectionViewLayout()
        }
        
        
         collectionView.reloadData()
        
    }
    
    // 검색을 할때마다 메서드 실행
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
}

extension MainViewController: UISearchBarDelegate {
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
    }
}
