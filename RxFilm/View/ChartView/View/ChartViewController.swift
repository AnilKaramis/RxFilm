//
//  ChartViewController.swift
//  RxFilm
//
//  Created by AnılKaramış on 6.06.2024.
//

import SnapKit
import UIKit
import RxSwift
import RxCocoa

class ChartViewController: UIViewController {
    
    let viewModel = ChartViewModel()
    let disposeBag = DisposeBag()
    
    //MARK: UI Properties
    
    let chartTableView : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = UIColor(named: Colors.background)
        tableView.allowsSelection = true
        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: Identifiers.chart_table_cell)
        return tableView
    }()
    let navigationAppearance : UINavigationBarAppearance = {
        let navigation = UINavigationBarAppearance()
        navigation.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigation.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigation.backgroundColor = UIColor(named: Colors.background)
        return navigation
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View Property
        self.title = "Charts"
        self.view.backgroundColor = UIColor(named: Colors.background)
        self.view.addSubview(chartTableView)
        self.chartTableView.delegate = self
        
        configureNavigation()
        applyConstraint()
        bindData()
        
        viewModel.requestData(category: .Popular)
    }
}
//MARK: Data Binding
extension ChartViewController {
    
    private func configureNavigation() {
        navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        navigationController?.navigationBar.standardAppearance = navigationAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        let categoryMenuItem = [
            UIAction(title: "Popular", image: UIImage(systemName: "flame.fill"), handler: { _ in self.viewModel.requestData(category: .Popular) }),
            UIAction(title: "Top Rated", image: UIImage(systemName: "star.fill"), handler: { _ in self.viewModel.requestData(category: .TopRated) }),
            UIAction(title: "Now Playing", image: UIImage(systemName: "theatermasks.fill"), handler: { _ in self.viewModel.requestData(category: .NowPlaying) })
        ]
        let categoryMenu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: categoryMenuItem)
        
        //NavigationBarItem
        let categoryButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"),primaryAction: nil, menu: categoryMenu)
        categoryButton.tintColor = .white
        navigationItem.rightBarButtonItem = categoryButton
    }
    
    private func applyConstraint() {
        chartTableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
    }
    
    
    func bindData() {
        
        viewModel.movieFrontObservable
            .debug()
            .bind(to: chartTableView.rx.items(cellIdentifier: Identifiers.chart_table_cell, cellType: ChartTableViewCell.self)) { index, movie, cell in
                cell.setData(rank: index, movie: movie)
            }
            .disposed(by: disposeBag)
        
        _ = viewModel.listTitleObaservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { self.navigationItem.title = $0 })

    }
}
//MARK: Cell Selection

extension ChartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ChartTableViewCell else { return }
        print(cell.contentId!)
        
        cell.isSelected = false
    }

}

//MARK: Cell Height

extension ChartViewController {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
        
    }
}
