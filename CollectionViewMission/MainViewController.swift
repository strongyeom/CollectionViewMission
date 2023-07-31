//
//  ViewController.swift
//  CollectionViewMission
//
//  Created by 염성필 on 2023/07/31.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    let movies = MovieInfo()
    
    var searchResult: [Movie] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingXib()
        setCollectionViewLayout()
        settingSearchController()
      
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
        
        if searchResult.isEmpty {
            return movies.movie.count
        } else {
            return searchResult.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        
    
        if !searchResult.isEmpty {
            let searchItem = searchResult[indexPath.row]
            cell.configureCell(item: searchItem)
        } else {
            let item = movies.movie[indexPath.item]
            cell.configureCell(item: item)

        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = movies.movie[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        vc.detailData = item
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension MainViewController: UISearchResultsUpdating {
    // 검색을 할때마다 메서드 실행
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "")
        
        guard let searchText = searchController.searchBar.text else { return }
        let searchFilterText = movies.movie.filter {
            $0.title.contains(searchText)
        }
        
        searchResult = searchFilterText
        
        print("searchResult",searchResult )
        collectionView.reloadData()
        
    }
}

extension MainViewController: UISearchBarDelegate {
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView.reloadData()
    }
}
