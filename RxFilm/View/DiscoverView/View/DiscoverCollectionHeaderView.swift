//
//  DiscoverCollectionHeaderView.swift
//  RxFilm
//
//  Created by AnılKaramış on 25.05.2024.
//

import UIKit
import Foundation

class DiscoverCollectionHeaderView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        lazy var label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 32)
        label.text = "Discover Movies"
        return label
    }()
    
    let searchField : PaddingTextField = {
        lazy var textfield = PaddingTextField()
        textfield.layer.cornerRadius = 20
        textfield.backgroundColor = UIColor(named: Colors.light_Background)
        //        textfield.placeholder = "Search..."
        let placeholderColor = UIColor(named: Colors.placeholder) ?? UIColor(named: Colors.light_Background)
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Search...",
            attributes: [NSAttributedString.Key.foregroundColor : placeholderColor])
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
        
        self.addSubview(titleLabel)
        self.addSubview(searchField)
        
        titleLabel.snp.makeConstraints {
           $0.left.equalToSuperview().offset(20)
           $0.right.equalToSuperview().offset(-20)
           $0.top.equalToSuperview().offset(20)
        }
        
        searchField.snp.makeConstraints {
           $0.top.equalTo(titleLabel.snp.bottom).offset(20)
           $0.left.equalToSuperview().offset(20)
           $0.right.equalToSuperview().offset(-20)
           $0.bottom.equalToSuperview().offset(-20)
        }
    }
}

