//
//  DetailViewController.swift
//  RxFilm
//
//  Created by AnılKaramış on 9.07.2024.
//

import Foundation
import SnapKit
import UIKit
import RxSwift

class DetailViewController: UIViewController {
    let viewModel: DetailViewModel
    let disposeBag = DisposeBag()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    init (id: Int) {
        self.viewModel = DetailViewModel(contentId: id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.imageView?.image = UIImage(systemName: "chevron.backward.circle")
        button.imageView?.tintColor = .white
        
        return button
    }()
    
    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
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
        image.backgroundColor = .systemOrange
        image.setContentHuggingPriority(.required, for: .horizontal)
        image.sizeToFit()
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 0
        label.minimumScaleFactor = 10
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    lazy var taglineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var runtimeIconLabel: IconLabel = {
        let compound = IconLabel()
        compound.icon.image = UIImage(systemName: "clock")
        return compound
    }()
    
    lazy var ratingIconLabel: IconLabel = {
        let compound = IconLabel()
        compound.icon.image = UIImage(systemName: "star.fill")
        compound.icon.tintColor = .orange
        return compound
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
    
    lazy var iconLabel: UIStackView = {
        let label = UIStackView()
        label.addArrangedSubview(runtimeIconLabel)
        label.addArrangedSubview(ratingIconLabel)
        label.axis = .horizontal
        label.distribution = .fill
        label.alignment = .leading
        label.spacing = 5
        return label
    }()
    
    lazy var mainInfoLabelStack: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(taglineLabel)
        view.addArrangedSubview(UIView())
        view.addArrangedSubview(iconLabel)
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
        view.layoutMargins = UIEdgeInsets.detailViewComponentInset
        posterImage.setContentHuggingPriority(.required, for: .horizontal)
        mainInfoLabelStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    //MARK: -Overview
    
    lazy var overView: DescriptionView = {
        let compound = DescriptionView()
        compound.titleLabel.text = "Overview"
        compound.contentLabel.text = "The only difference between a problem and a solution is that people understand the solution"
        return compound
    }()
    
    //MARK: Date & Genre
    lazy var dateGenre: DoubleColumnDescriptionView = {
        let compound = DoubleColumnDescriptionView()
        compound.leftDescription.titleLabel.text = "Release Date"
        compound.leftDescription.contentLabel.text = "2022.01.03"
        compound.rightDescription.titleLabel.text = "Genre"
        compound.rightDescription.contentLabel.text = "Action, Comedy, SF"
        return compound
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: Colors.background)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.preferredContentSize.height = 0.0
        
        bindData()
        applyConstraint()
    }
    
    private func bindData() {
        
        _ = viewModel.movieDetailObservable.observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                
                guard let movieDetail = data else { return }
                self.applyMovieDetailData(data: movieDetail)
            })
    }
    
    private func applyConstraint() {
        
        //Setup ScrollView
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // Add to Subview into contentView
        self.contentView.addSubview(backButton)
        self.contentView.addSubview(backDropImage)
        self.contentView.addSubview(mainInfoStackView)
        self.contentView.addSubview(overView)
        self.contentView.addSubview(dateGenre)
        
        // Set Constraint
        backDropImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.lessThanOrEqualTo(backDropImage.snp.width).multipliedBy(0.7)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
            make.height.equalTo(backDropImage.snp.height).multipliedBy(0.15)
            make.width.equalTo(backButton.snp.height)
        }
        
        mainInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(backDropImage.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.view.snp.width).multipliedBy(0.45)
            
        }
        
        appendView(view: overView, target: mainInfoStackView)
        appendView(view: dateGenre, target: overView)
        dateGenre.snp.makeConstraints{ $0.bottom.equalToSuperview() }
    }
    
    private func applyMovieDetailData(data: MovieDetail) {
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: APIService.configureUrlString(imagePath: data.backdropPath)) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.sync {
                self.backDropImage.image = UIImage(data: imageData)
            }
        }
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: APIService.configureUrlString(imagePath: data.posterPath)) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.sync {
                self.posterImage.image = UIImage(data: imageData)
            }
        }
        
        self.titleLabel.text = data.title
        self.taglineLabel.text = data.tagline
        
        self.runtimeIconLabel.label.text = String(data.runtime)
        self.ratingIconLabel.label.text = String(data.voteAverage)
        
        self.overView.contentLabel.text = data.overview
        self.dateGenre.leftDescription.contentLabel.text = data.releaseDate
        
        let genres = data.genres.map { $0.name }.joined(separator: ",")
        self.dateGenre.rightDescription.contentLabel.text = genres
    }
}

// Constrait Function
extension DetailViewController {
    
    private func appendView(view: UIView, target: UIView) {
        view.snp.makeConstraints { make in
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
        DetailViewController(id: 634649)
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
