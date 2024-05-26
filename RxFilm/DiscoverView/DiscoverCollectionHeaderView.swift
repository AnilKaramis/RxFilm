//
//  DiscoverCollectionHeaderView.swift
//  RxFilm
//
//  Created by AnılKaramış on 25.05.2024.
//

import UIKit

class DiscoverCollectionHeaderView: UICollectionReusableView {
    let titleLabel: UILabel = {
    lazy var label = UILabel()
       label.textColor = .white
       label.numberOfLines = 0
       label.textAlignment = .left
       label.font = UIFont(name: "AvenirNext-medium", size: 32.0)!
        return label
    }()
    
    let searchField : UITextField = {
    lazy var textfield = UITextField()
       textfield.layer.cornerRadius = 20
       textfield.layer.borderColor = UIColor.gray.cgColor
       textfield.layer.borderWidth = 10
       textfield.backgroundColor = .black
       textfield.placeholder = "Search..."
        return textfield
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DiscoverCollectionHeaderView {
    private func configure() {
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
        }
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(50)
        }
        
    }
}

