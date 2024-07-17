//
//  DiscoverCollectionViewCell.swift
//  RxFilm
//
//  Created by AnılKaramış on 27.05.2024.
//

import UIKit
import SnapKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    var contentId: Int?
    
    //MARK: Properties
    let posterImage : UIImageView = {
        lazy var imageView = UIImageView()
        imageView.image = UIImage(named: Image.img_placeholder)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let movieTitle : UILabel = {
        lazy var text = UILabel()
        text.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        text.textColor = .white
        text.numberOfLines = 3
        text.minimumScaleFactor = 5
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView : UIStackView = {
            let view = UIStackView()
            view.addArrangedSubview(posterImage)
            view.addArrangedSubview(movieTitle)
            view.axis = .vertical
            view.distribution = .fill
            view.alignment = .fill
            view.spacing = 0
            return view
        }()
        
        self.addSubview(stackView)
        
        //MARK: Constraints Properties
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        posterImage.snp.makeConstraints {
            $0.left.right.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        movieTitle.setContentHuggingPriority(.required, for: .vertical)
        movieTitle.setContentHuggingPriority(.required, for: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: -Insert data to cell
extension DiscoverCollectionViewCell {
    
    func setData(movie:MovieFront) {
        
        self.movieTitle.text = movie.title
        self.contentId = movie.id
        
        DispatchQueue.global().async {
            guard let imagePath = movie.posterPath else {return}
            
            guard let imageURL = URL(string: APIService.configureUrlString(imagePath: imagePath)) else { return }

            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data:imageData)
            }
        }
    }
}
