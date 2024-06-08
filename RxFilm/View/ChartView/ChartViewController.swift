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
    
    let ChartTableView : UITableView = {
        var tableView = UITableView()
        tableView.backgroundColor = UIColor(named: Colors.background)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifiers.discover_collection_cell)
        tableView.backgroundColor = UIColor(named: Colors.background)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View Property
        self.title = "Charts"
        self.view.backgroundColor = UIColor(named: Colors.background)
        
        ChartTableView.delegate = self
        ChartTableView.dataSource = self
        
        SetupConstraints()
    }
    func SetupConstraints() {
        
        self.view.addSubview(ChartTableView)
        
        ChartTableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }
    }
}

extension ChartViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        
        guard let cell = ChartTableView.dequeueReusableCell(withIdentifier: Identifiers.chart_table_cell, for: indexPath) as? UITableViewCell else { fatalError("Unable to dequeue ReminderCell") }
        
        // set the text from the data model
        
        cell.textLabel?.text = "\(indexPath.row). Movie moview "
        cell.imageView?.image = UIImage(named: "img_placeholder")
        return cell
    }
}

//#if DEBUG
//
//import SwiftUI
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//
//func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//}
//func makeUIViewController(context: Context) -> UIViewController{
//    ChartViewController()
//    }
//}
//@available(iOS 13.0, *)
//struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ViewControllerRepresentable()
//                .ignoresSafeArea()
//                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
//                .previewDevice(PreviewDevice(rawValue: "iPhone 15"))
//        }
//        
//    }
//    } #endif
