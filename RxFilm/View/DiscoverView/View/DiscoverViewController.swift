//
//  DiscoverViewController.swift
//  RxFilm
//
//  Created by AnılKaramış on 25.05.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DiscoverViewController:UIViewController {
    
    ///Model tanimla !
    let ViewModel = DiscoverViewModel()
    let disposeBag = DisposeBag()
    
    // CollectionView
    lazy var CollectionView : UICollectionView = {
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        //        flowLayout.itemSize = CGSize(width: 150, height: 150)
        flowLayout.headerReferenceSize = CGSize(width: self.preferredContentSize.width, height: 180)
        //        return UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        
        // CollectionView
        
        var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        
        collectionView.register(DiscoverCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.discover_collection_cell)
        collectionView.register(DiscoverCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Identifiers.discover_collection_header)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RxFilm"
        
        self.view.backgroundColor = UIColor(named: Colors.background)
//        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        initUI()
        
        //Fetch Data
       
       
    }
}

//MARK: -Draw UI

extension DiscoverViewController {
    
    private func initUI() {
        
        super.view.addSubview(CollectionView)
        
        CollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
//MARK: -Collection View Configuration
//TODO: will be deleted when RxCocoa added

extension DiscoverViewController {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return ViewModel.movies.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        //Cell Property
//        let movie = ViewModel.movies[indexPath.row]
//        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.discover_collection_cell, for: indexPath) as? DiscoverCollectionViewCell else { return DiscoverCollectionViewCell()}
//        cell.setData(movie: movie)
//        
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.discover_collection_header, for: indexPath)
    }
}
extension DiscoverViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! DiscoverCollectionViewCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.size.width - 60)/3
        return CGSize(width: itemWidth, height: itemWidth * 1.75)
    }
}
