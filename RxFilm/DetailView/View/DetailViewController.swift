//
//  DetailViewController.swift
//  RxFilm
//
//  Created by AnılKaramış on 9.07.2024.
//

import Foundation
import SnapKit
import UIKit

class DetailViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    //MARK: BackDrop
    lazy var backDropImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .darkGray
        
        return image
    }()
    
    //MARK: Main Info
    lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "img_placeholder")    // placeholder image
        
        image.setContentHuggingPriority(.required, for: .horizontal)
        
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 0
        label.minimumScaleFactor = 10
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    lazy var runtimeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock")
        image.tintColor = .lightGray
        image.setContentHuggingPriority(.required, for: .vertical)
        
        return image
    }()
    
    lazy var runtimeLabel: UILabel = {
        let label = UILabel()
        label.text = "000"         // placeholder
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        return label
    }()
    
    lazy var runtimeStack: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(runtimeIcon)
        view.addArrangedSubview(runtimeLabel)
        
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 3
        
        return view
    }()
    
    lazy var ratingIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .orange
        image.setContentHuggingPriority(.required, for: .vertical)
        
        return image
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"         // placeholder
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        return label
    }()
    
    lazy var ratingStack: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(ratingIcon)
        view.addArrangedSubview(ratingLabel)
        
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 3
        
        return view
    }()
    
    lazy var mainInfoLabelStack: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(runtimeStack)
        view.addArrangedSubview(UIView())
        view.addArrangedSubview(ratingStack)
        
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = 5
        
        return view
    }()
    
    lazy var mainInfoStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(posterImage)
        view.addArrangedSubview(mainInfoLabelStack)
        
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 10
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 20)
        
        return view
    }()
    //MARK: -Overview
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
       label.text = "OverView"
       label.textColor = .white
       label.textAlignment = .left
       
       label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
       label.numberOfLines = 0
       label.minimumScaleFactor = 10
       
        label.setContentHuggingPriority(.required, for: .vertical)
        
        return label
    }()
    
    lazy var overviewContentLabel: UILabel = {
        let label = UILabel()
       label.text = "This is Overview of movie"   // placeholder
       label.textColor = .lightGray
       label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        return label
    }()
    lazy var overviewStack: UIStackView = {
        let view = UIStackView()
      view.addArrangedSubview(overviewLabel)
      view.addArrangedSubview(overviewContentLabel)
      
      view.axis = .vertical
      view.distribution = .fill
      view.alignment = .fill
      view.spacing = 3
      view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        return view
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: Colors.background)
        
        bindData()
        applyConstraint()
    }
    
    private func bindData() {
        
    }
    
    //MARK: Constraints
    private func applyConstraint() {
        
        let dividerArray = Array(repeating: DetailViewController.dividerView, count: 4)
        
        //Setup ScrollView
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        // Add to Subview into contentView
        self.contentView.addSubview(backDropImage)
        self.contentView.addSubview(mainInfoStackView)
        self.contentView.addSubview(overviewStack)
        dividerArray.forEach{ self.contentView.addSubview($0) }
        
        // Set Constraint
        backDropImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(backDropImage.snp.width).multipliedBy(0.5)
            
        }
        mainInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(backDropImage.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.view.snp.width).multipliedBy(0.45)
            
        }
        
        ratingIcon.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(ratingIcon.snp.height)
            
        }
        runtimeStack.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(runtimeIcon.snp.height)
            
        }
        placeToBottomOfView(placer: dividerArray[0], target: mainInfoStackView)
        
        placeToBottomOfView(placer: overviewStack, target: mainInfoStackView)
        
    }
}
//MARK: -Divider
extension DetailViewController {
    
    static let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.snp.makeConstraints { make in
            make.height.equalTo(0.5)
        }
        return view
    }()
    
    // Place UIView to bottom anchor of target
    private func placeToBottomOfView(placer: UIView, target: UIView) {
        placer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(target.snp.bottom)

        }
    }
}

#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
    }
    @available(iOS 13.0.0, *)
    func makeUIViewController(context: Context) -> UIViewController{
        DetailViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Mini"))
        }
    }
} #endif

