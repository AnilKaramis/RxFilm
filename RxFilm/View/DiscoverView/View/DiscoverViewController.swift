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
    
    
    let ViewModel = DiscoverViewModel()
    let disposeBag = DisposeBag()
    
    // CollectionView
    lazy var CollectionView : UICollectionView = {
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.headerReferenceSize = CGSize(width: self.preferredContentSize.width, height: 180)
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        
        
        // CollectionView
        
        var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        
        collectionView.register(DiscoverCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.discover_collection_cell)
        collectionView.register(DiscoverCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Identifiers.discover_collection_header)
        collectionView.backgroundColor = UIColor(named: Colors.background)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        CollectionView.delegate = self
        
        //View Property
        
        self.view.backgroundColor = UIColor(named: Colors.background)
        super.view.addSubview(CollectionView)
        
        Layout()
        movieObservable()
        
    }
}
//MARK: -Extension ViewDidLoad

extension DiscoverViewController {
    private func Layout() {
        CollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    private func movieObservable() {
        ViewModel.movieFrontObservable
            .debug()
            .bind(to: CollectionView.rx.items(cellIdentifier: Identifiers.discover_collection_cell,cellType: DiscoverCollectionViewCell.self)) { index, movie, cell in
            cell.setData(movie: movie)
        }
        .disposed(by: disposeBag)
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
        let itemWidth = (collectionView.frame.size.width - 60)/2
        return CGSize(width: itemWidth, height: itemWidth * 1.75)
    }
}
