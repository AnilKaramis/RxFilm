//
//  DiscoverViewController.swift
//  RxFilm
//
//  Created by AnılKaramış on 25.05.2024.
//

import UIKit
import SnapKit

class DiscoverViewController:UIViewController {
    
    //Example Data
    let movies = [
        MovieFront(title: "Ornekfilm1", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", genre: "Genre", releaseDate: "2023-10-10", ratingScore: 9.1, ratingCount: 1234),
        MovieFront(title: "Ornekfilm2", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", genre: "Genre", releaseDate: "2023-10-10", ratingScore: 9.2, ratingCount: 456),
        MovieFront(title: "Ornekfilm3", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", genre: "Genre", releaseDate: "2023-10-10", ratingScore: 9.4, ratingCount: 56),
        MovieFront(title: "Ornekfilm4", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", genre: "Genre", releaseDate: "2023-10-10", ratingScore: 9.6, ratingCount: 678)
    ]
    
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
        CollectionView.dataSource = self
        CollectionView.delegate = self
        
        initUI()
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

extension DiscoverViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Cell Property
        let movie = movies[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.discover_collection_cell, for: indexPath) as? DiscoverCollectionViewCell else { return DiscoverCollectionViewCell()}
        cell.setData(movie: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.discover_collection_header, for: indexPath)
    }
}
extension DiscoverViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
//        let cell = collectionView.cellForItem(at: indexPath) as! DiscoverCollectionViewCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.frame.size.width - 60)/3
        return CGSize(width: itemWidth, height: itemWidth * 1.75)
    }
}

//#if DEBUG
//import SwiftUI
//
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiView: UIViewController,context: Context) {
//            // leave this empty
//    }
//    func makeUIViewController(context: Context) -> UIViewController{
//        DiscoverViewController()
//        }
//}
//struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ViewControllerRepresentable()
//                .ignoresSafeArea()
//                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
//                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
//        }
//    }
//}
//#endif
