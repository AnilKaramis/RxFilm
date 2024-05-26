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
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        
        return UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.dataSource = self
        
        initUI()
    }
}

//MARK: Draw UI
extension DiscoverViewController {
   
    private func initUI() {
        super.view.addSubview(CollectionView)
        CollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.discover_collection_cell)
        CollectionView.backgroundColor = UIColor(named: Colors.background)
        CollectionView.snp.makeConstraints { $0.edges.equalToSuperview()}
    }
}

extension DiscoverViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.discover_collection_cell, for: indexPath)
        cell.backgroundColor = .systemRed
        return cell
    }
}
extension DiscoverViewController:UICollectionViewDelegate {
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
