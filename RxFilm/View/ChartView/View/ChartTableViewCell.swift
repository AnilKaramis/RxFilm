//
//  ChartTableViewCell.swift
//  RxFilm
//
//  Created by AnılKaramış on 8.06.2024.
//

import UIKit
import Cosmos
import SnapKit

class ChartTableViewCell: UITableViewCell {
    
    var contentId: Int?
    
    //MARK: - Properties
    
    lazy var rankLabel : UILabel = {
        
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.sizeToFit()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    lazy var posterImage : UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "img_placeholder")  // add placeholder image
        return image
    }()
    
    lazy var titleLabel : UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 2
        label.minimumScaleFactor = 10
        return label
    }()
    
    lazy var genreLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var releaseDateLabel : UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var starRating : CosmosView = {
        var starView = CosmosView()
        starView.settings.totalStars = 5
        starView.settings.emptyBorderColor = .orange
        starView.settings.filledColor = .orange
        starView.settings.fillMode = .half
        starView.settings.updateOnTouch = false
        starView.settings.starSize = 17
        starView.settings.starMargin = 1
        return starView
    }()
    
    lazy var ratingCountLabel : UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    // ChartTableViewCell initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let starStackView : UIStackView = {
            let view = UIStackView()
            //Add View
            view.addArrangedSubview(starRating)
            view.addArrangedSubview(ratingCountLabel)
            view.addArrangedSubview(UIView())
            
            // Add Property
            view.axis = .horizontal
            view.distribution = .fill
            view.alignment = .fill
            view.spacing = 5
            return view
        }()
        
        let infoStackView : UIStackView = {
            let view = UIStackView()
            
            // Add View
            view.addArrangedSubview(titleLabel)
            view.addArrangedSubview(genreLabel)
            view.addArrangedSubview(releaseDateLabel)
            view.addArrangedSubview(starStackView)
            
            // Add Property
            view.axis = .vertical
            view.distribution = .fill
            view.alignment = .fill
            view.spacing = 5
            return view
        }()
        
        self.backgroundColor = UIColor(named: Colors.background)
        self.selectionStyle = .none
        
        //MARK: Set Constraints
        self.addSubview(rankLabel)
        self.addSubview(posterImage)
        self.addSubview(infoStackView)
        
        rankLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        posterImage.snp.makeConstraints {
            $0.left.equalTo(rankLabel.snp.right).offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(100)
        }
        
        infoStackView.snp.makeConstraints {
            $0.left.equalTo(posterImage.snp.right).offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-20)
            $0.right.equalToSuperview().offset(-10)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChartTableViewCell {
    
    //MARK: - Set Data
    
    func setData(rank: Int,movie: MovieFront) {
        contentId = movie.id
        rankLabel.text = "\(rank+1)"
        titleLabel.text = movie.title
        genreLabel.text = movie.genre
        releaseDateLabel.text = movie.releaseDate
        starRating.rating = movie.ratingScore/2
        ratingCountLabel.text = "\(movie.ratingCount)"
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: movie.posterPath) else {return}
            guard let imageData = try? Data(contentsOf: imageURL) else {return}
            
            DispatchQueue.main.sync {
                self.posterImage.image = UIImage(data: imageData)
            }
        }
    }
}
