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
    
    let ChartTableView : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = UIColor(named: Colors.background)
        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: Identifiers.chart_table_cell)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View Property
        self.title = "Charts"
        self.view.backgroundColor = UIColor(named: Colors.background)
        self.view.addSubview(ChartTableView)
        
        Layout()
        bindDataModel()
    }
    func Layout() {
        
        ChartTableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
    }
}
//MARK: Data Binding
extension ChartViewController {
    func bindDataModel() {
        viewModel.movieFrontObservable
            .bind(to: ChartTableView.rx.items(cellIdentifier: Identifiers.chart_table_cell, cellType: ChartTableViewCell.self)) { index, movie, cell in
                cell.setData(rank: index, movie: movie)
            }
            .disposed(by: disposeBag)
    }
}
