//
//  DescriptionView.swift
//  RxFilm
//
//  Created by AnılKaramış on 9.07.2024.
//

import Foundation
import UIKit

class DescriptionView: UIView {
    
    lazy var topDivider: UIView = {
        let view = UIView()
       view.backgroundColor = .gray
        view.isHidden = false
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
       label.textColor = .white
       label.textAlignment = .left
       label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
       label.numberOfLines = 0
       label.minimumScaleFactor = 10
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
       label.numberOfLines = 0
       label.textColor = .lightGray
       label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(titleLabel)
       view.addArrangedSubview(contentLabel)
       view.axis = .vertical
       view.distribution = .fill
       view.alignment = .fill
       view.spacing = 3
       view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
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
        self.addSubview(stack)

        stack.snp.makeConstraints { make in
          make.edges.equalToSuperview()
        }
        
        // Add Divider Line
        self.addSubview(topDivider)
        
        topDivider.snp.makeConstraints { make in
            make.height.equalTo(0.4)
            make.centerY.equalTo(self.snp.top)
            make.left.right.equalToSuperview()
        }
    }
}

