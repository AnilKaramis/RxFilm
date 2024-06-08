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
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
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
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var genreLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor(named: Colors.placeholder)
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var releaseDateLabel : UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var starRating : CosmosView = {
        var starView = CosmosView()
        starView.settings.totalStars = 5
        starView.settings.emptyBorderColor = .orange
        starView.settings.filledColor = .orange
        starView.settings.fillMode = .half
        starView.settings.updateOnTouch = false
        return starView
    }()
    
    // ChartTableViewCell initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let infoStackView : UIStackView = {
            var view = UIStackView()
            
            // Add View
           view.addSubview(titleLabel)
           view.addSubview(genreLabel)
           view.addSubview(releaseDateLabel)
           view.addSubview(starRating)
            
            // Property
           view.axis = .vertical
           view.distribution = .fill
           view.spacing = 150
           return view
        }()
        
        self.backgroundColor = UIColor(named: Colors.background)
        
        //MARK: Set Constraints
        self.addSubview(rankLabel)
        self.addSubview(posterImage)
        self.addSubview(infoStackView)
        
        rankLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().offset(0)
            make.width.equalTo(0)
        }
        
        posterImage.snp.makeConstraints { make in
            make.left.equalTo(rankLabel.snp.right).offset(10)
            make.top.bottom.equalToSuperview().offset(0)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.right.equalTo(posterImage.snp.left).offset(50)
            make.bottom.top.equalToSuperview().offset(0)
            make.right.greaterThanOrEqualToSuperview()
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
        genreLabel.text = "Comdey"
        releaseDateLabel.text = "2000.00.00"
        starRating.rating = 3.0
    }
}
