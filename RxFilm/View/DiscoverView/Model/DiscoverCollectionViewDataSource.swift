//
//  DiscoverCollectionViewDataSource.swift
//  RxFilm
//
//  Created by AnılKaramış on 30.06.2024.
//

import RxDataSources

struct DiscoverCollectionViewItem {
    let movie: MovieFront
    
    init(movie: MovieFront) {
        self.movie = movie
    }
}

struct DiscoverCollectionViewSection {
    let items: [DiscoverCollectionViewItem]
    
    init(items: [DiscoverCollectionViewItem]) {
        self.items = items
    }
}

extension DiscoverCollectionViewSection: SectionModelType {
    typealias Item = DiscoverCollectionViewItem
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}

struct DiscoverCollectionViewDataSource {
    typealias DataSource = RxCollectionViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<DiscoverCollectionViewSection> {
        return .init { dataSource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.discover_collection_cell, for: indexPath) as? DiscoverCollectionViewCell else { return UICollectionViewCell()}
            
            
            cell.setData(movie: item.movie)
            return cell
        }
    }
    
}

