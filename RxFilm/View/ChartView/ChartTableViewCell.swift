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
    
    lazy var rankLabel : UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.sizeToFit()
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
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
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
            var view = UIStackView()
            //Add View
            view.addArrangedSubview(starRating)
            view.addArrangedSubview(ratingCountLabel)
            
            // Add Property
            view.axis = .horizontal
            view.distribution = .fill
            view.alignment = .fill
            view.spacing = 10
            return view
        }()
        
        let infoStackView : UIStackView = {
            var view = UIStackView()
            let emptyView = UIView()
            
            emptyView.heightAnchor.constraint(equalToConstant: 3).isActive = true
            
            // Add View
            view.addArrangedSubview(titleLabel)
            view.addArrangedSubview(genreLabel)
            view.addArrangedSubview(releaseDateLabel)
            view.addArrangedSubview(starStackView)
            view.addArrangedSubview(emptyView)
            
            // Add Property
            view.axis = .vertical
            view.distribution = .fill
            view.alignment = .fill
            view.spacing = 10
            return view
        }()
        
        self.backgroundColor = UIColor(named: Colors.background)
        
        //MARK: Set Constraints
        self.addSubview(rankLabel)
        self.addSubview(posterImage)
        self.addSubview(infoStackView)
        
        rankLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        posterImage.snp.makeConstraints { make in
            make.left.equalTo(rankLabel.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.left.equalTo(posterImage.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.lessThanOrEqualToSuperview().offset(-10)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChartTableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /// to fetch the data afterwards
    func setSampleData(rank: Int) {
        rankLabel.text = "\(rank+1)"
        titleLabel.text = "Title"
        genreLabel.text = "Genre"
        releaseDateLabel.text = "yyyy.mm.dd"
        starRating.rating = 3.0
        ratingCountLabel.text = "(123)"
    }
}
