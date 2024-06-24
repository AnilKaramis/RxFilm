//
//  ChartViewController.swift
//  RxFilm
//
//  Created by AnılKaramış on 6.06.2024.
//

import SnapKit
import UIKit
import SwiftUI

class ChartViewController: UIViewController {
    
    // Example Data
    
    let movies = [
        MovieFront(title: "Ornekfilm1", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", genre: "Genre", releaseDate: "2023-10-10", ratingScore: 9.1, ratingCount: 1234),
        MovieFront(title: "Ornekfilm2", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", genre: "Genre", releaseDate: "2023-10-10", ratingScore: 9.2, ratingCount: 456),
        MovieFront(title: "Ornekfilm3", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", genre: "Genre", releaseDate: "2023-10-10", ratingScore: 9.4, ratingCount: 56),
        MovieFront(title: "Ornekfilm4", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", genre: "Genre", releaseDate: "2023-10-10", ratingScore: 9.6, ratingCount: 678)
    ]
    
    let ChartTableView : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = UIColor(named: Colors.background)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifiers.chart_table_cell)
        tableView.backgroundColor = UIColor(named: Colors.background)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View Property
        self.title = "Charts"
        self.view.backgroundColor = UIColor(named: Colors.background)
        
//        ChartTableView.delegate = self
        ChartTableView.dataSource = self
        
        SetupConstraints()
    }
    func SetupConstraints() {
        
        self.view.addSubview(ChartTableView)
        
        ChartTableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
    }
}
//MARK: -Data Source
extension ChartViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.chart_table_cell, for: indexPath) as? ChartTableViewCell else { fatalError("Unable to dequeue ReminderCell") }
        
        // set the text from the data model

        cell.setData(rank: indexPath.row, movie: movies[indexPath.row])
        return cell
    }
}
