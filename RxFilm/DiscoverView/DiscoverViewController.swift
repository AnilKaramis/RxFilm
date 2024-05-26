//
//  DiscoverViewController.swift
//  RxFilm
//
//  Created by AnılKaramış on 25.05.2024.
//

import UIKit
import SnapKit

class DiscoverViewController:UIViewController {
    
    
    
    lazy var CollectionView : UICollectionView = {
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        flowLayout.itemSize = CGSize(width: 150, height: 150)
        flowLayout.headerReferenceSize = CGSize(width: self.preferredContentSize.width, height: 180)
        return UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.dataSource = self
        
        initUI()
    }
}

//MARK: -Draw UI

extension DiscoverViewController {
   
    private func initUI() {
        
        super.view.addSubview(CollectionView)
        
        CollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.discover_collection_cell)
        CollectionView.register(DiscoverCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Identifiers.discover_collection_header)
        CollectionView.backgroundColor = UIColor(named: Colors.background)
        CollectionView.snp.makeConstraints { $0.edges.equalToSuperview()}
    }
}
//MARK: -Collection View Configuration

extension DiscoverViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Cell Property
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.discover_collection_cell, for: indexPath)
        cell.backgroundColor = .systemRed
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifiers.discover_collection_header, for: indexPath)
    }
}
extension DiscoverViewController:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        printContent(indexPath.row)
    }
}

#if DEBUG
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiView: UIViewController,context: Context) {
            // leave this empty
    }
    func makeUIViewController(context: Context) -> UIViewController{
        DiscoverViewController()
        }
}
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
    }
}
#endif
