//
//  DiscoverCollectionHeaderView.swift
//  RxFilm
//
//  Created by AnılKaramış on 25.05.2024.
//

import UIKit
import Foundation
import RxSwift

class DiscoverCollectionHeaderView: UICollectionReusableView {

    let viewModel = DiscoverViewModel.shared
    let disposeBag = DisposeBag()
    
    // MARK: UI Properties
    let titleLabel: UILabel = {
        lazy var label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 40 , weight: .bold)
        label.text = "Discover Movies"
        return label
    }()
    
    let searchField : PaddingTextField = {
        lazy var textfield = PaddingTextField()
        textfield.layer.cornerRadius = 20
        textfield.backgroundColor = UIColor(named: Colors.light_Background)
        textfield.textColor = .white

        //        textfield.placeholder = "Search..."
        let placeholderColor = UIColor(named: Colors.placeholder) ?? UIColor(named: Colors.light_Background)
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Search...",
            attributes: [NSAttributedString.Key.foregroundColor : placeholderColor!])
        return textfield
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        bindSearchField()
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
    private func bindSearchField() {
        self.searchField.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5), scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .distinctUntilChanged()
            .subscribe(onNext: {
                self.viewModel.requestData(keyword: $0, page: 1) })
            .disposed(by: disposeBag)
    }
}

