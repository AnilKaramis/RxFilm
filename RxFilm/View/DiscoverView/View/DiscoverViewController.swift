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
import RxDataSources

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
        
        CollectionView.delegate = self
  
        Layout()
        bindData()
        
        ViewModel.requestData()
    }
}
//MARK: -Extension ViewDidLoad

extension DiscoverViewController {
    private func Layout() {
        self.title = "Home"
        self.view.backgroundColor = UIColor(named: Colors.background)
        super.view.addSubview(CollectionView)
        CollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    private func bindData() {
        ViewModel.movieFrontObservable
            .bind(to: CollectionView.rx.items(dataSource: ViewModel.dataSource))
            .disposed(by: disposeBag)
    }
}
//MARK: -Collection View Configuration

extension DiscoverViewController {
  
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
