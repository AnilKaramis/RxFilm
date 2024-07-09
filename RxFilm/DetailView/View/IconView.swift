//
//  IconView.swift
//  RxFilm
//
//  Created by AnılKaramış on 9.07.2024.
//

import Foundation
import UIKit
import SnapKit

class IconView: UIView {
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.tintColor = .lightGray
        image.setContentHuggingPriority(.required, for: .vertical)
        
        return image
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView()
        
        view.addArrangedSubview(icon)
        view.addArrangedSubview(label)
        
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 3
        
        return view
    }()
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        self.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        icon.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(icon.snp.height)
        }
    }
}

