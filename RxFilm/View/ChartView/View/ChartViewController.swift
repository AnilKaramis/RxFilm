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
        tableView.allowsSelection = false
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

        viewModel.requestData()
    }
}
//MARK: Data Binding
extension ChartViewController {
    
    private func configureNavigation() {
        navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
        navigationController?.navigationBar.standardAppearance = navigationAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.title = "Popular"
        
        let categoryButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), style: .plain, target: self, action: #selector(addTapped))
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
    }
    
    @objc func addTapped() {
        print(#function)
    }
}

extension ChartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160

    }
}
