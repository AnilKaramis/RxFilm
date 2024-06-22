//
//  DiscoverCollectionViewCell.swift
//  RxFilm
//
//  Created by AnılKaramış on 27.05.2024.
//

import UIKit
import SnapKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    let posterImage : UIImageView = {
        lazy var imageView = UIImageView()
        imageView.image = UIImage(named: "img_placeholder")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let movieTitle : UILabel = {
        lazy var text = UILabel()
        text.font = UIFont.systemFont(ofSize: 10)
        text.textColor = .white
        text.numberOfLines = 2
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(movieTitle)
        self.addSubview(posterImage)
        
        //MARK: Constraints Properties
        
        posterImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
        
        movieTitle.snp.makeConstraints {
            $0.top.equalTo(posterImage.snp.bottom).offset(5)
            $0.bottom.greaterThanOrEqualToSuperview()
            $0.leading.equalTo(posterImage.snp.leading)
            $0.trailing.equalTo(posterImage.snp.trailing)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: -Insert data to cell
extension DiscoverCollectionViewCell {
    
    func insertData(movie:MovieFront) {
        
        movieTitle.text = movie.title
        movieTitle.textColor = .red
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: "https://image.tmdb.org/t/p/original/\(movie.posterPath)") else {
                return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.sync {
                self.posterImage.image = UIImage(data:imageData)
            }
        }
    }
}
