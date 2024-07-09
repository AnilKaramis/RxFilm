//
//  CreditViewController.swift
//  RxFilm
//
//  Created by AnılKaramış on 8.06.2024.
//

import UIKit
import SnapKit

class CreditViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: Colors.background)
        
        let createPageLabel : UILabel = {
            var label = UILabel()
            label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            label.textColor = .white
            label.text = "This is Credit Page"
            return label
        }()
        
        self.view.addSubview(createPageLabel)
        
        createPageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}

//#if DEBUG
//import SwiftUI
//struct ViewControllerRepresentable: UIViewControllerRepresentable {
//    
//    func updateUIViewController(_ uiView: UIViewController,context: Context) {
//        // leave this empty
//    }
//    @available(iOS 13.0.0, *)
//    func makeUIViewController(context: Context) -> UIViewController{
//        CreditViewController()
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
//    }
//} #endif
//
