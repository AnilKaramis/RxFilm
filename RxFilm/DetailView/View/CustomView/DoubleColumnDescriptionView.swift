//
//  DoubleColumnDescriptionView.swift
//  RxFilm
//
//  Created by AnılKaramış on 9.07.2024.
//

import Foundation
import UIKit

class DoubleColumnDescriptionView: UIView {
    
    lazy var leftDescription = DescriptionView()
    lazy var rightDescription = DescriptionView()
    
    lazy var wrapperStack: UIStackView = {
        let view = UIStackView()
      view.addArrangedSubview(leftDescription)
      view.addArrangedSubview(rightDescription)
      view.axis = .horizontal
      view.distribution = .fillEqually
      view.alignment = .fill
        view.spacing = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        addSubview(wrapperStack)
        
        wrapperStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
