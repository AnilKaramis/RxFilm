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
    let viewModel = DiscoverViewModel()
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
        
        self.dismissKeyboard()
        CollectionView.delegate = self
        
        navigationController?.setNavigationBarHidden(true, animated: false)

        setupLayout()
        bindData()
        
        viewModel.requestData()
    }
}
//MARK: -Extension ViewDidLoad

extension DiscoverViewController {
    private func setupLayout() {
        self.title = "Home"
        self.view.backgroundColor = UIColor(named: Colors.background)
        super.view.addSubview(CollectionView)
        CollectionView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    private func bindData() {
        viewModel.movieFrontObservable
            .bind(to: CollectionView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: disposeBag)
    }
}
//MARK: -CollectionView Frame

extension DiscoverViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.size.width - 60)/2
        return CGSize(width: itemWidth, height: itemWidth * 1.75)
    }
}
extension DiscoverViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DiscoverCollectionViewCell else { return }
        guard let id = cell.contentId else { return }
        
        let vc = DetailViewController(id: id)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: -Dismiss Keyaord
extension DiscoverViewController {
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:    #selector(DiscoverViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}

