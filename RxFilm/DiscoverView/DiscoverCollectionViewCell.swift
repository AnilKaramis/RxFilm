//
//  DiscoverCollectionViewCell.swift
//  RxFilm
//
//  Created by AnılKaramış on 27.05.2024.
//

import UIKit
import SnapKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    let posterImage : UIImageView = {
        lazy var imageView = UIImageView()
        imageView.image = UIImage(named: "img_placeholder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let movieTitle : UILabel = {
        lazy var text = UILabel()
        text.font = UIFont.systemFont(ofSize: 20)
        text.textColor = .white
        return text
    }()
    func insertData (imageURLString: String, title: String) {
        DispatchQueue.global().async {
            guard let imageURL = URL(string: imageURLString) else { return }
        }
    }
}
