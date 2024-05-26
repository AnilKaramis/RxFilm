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
        
        // Image in searchField
        //        var imageView = UIImageView()
        //        imageView.image = UIImage(named: "magnifyingglass")
        //        textfield.leftView = imageView
        //        textfield.leftViewMode = .always
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
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        }
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
    }
}

class PaddingTextField: UITextField {
    
    let textPadding = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}

