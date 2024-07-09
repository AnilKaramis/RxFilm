//
//  ChartViewModel.swift
//  RxFilm
//
//  Created by AnılKaramış on 24.06.2024.
//

import Foundation
import RxSwift
import RxRelay

class ChartViewModel {
    let movieFrontObservable = BehaviorRelay<[MovieFront]>(value: [])
    let listTitleObaservable = BehaviorSubject<String>(value: MovieListCategory.Popular.title)
    
//MARK: -Map
    
    func requestData(category: MovieListCategory) {
        let url = APIService.configureUrlString(category: category, language: .English, page: 1)
        _ = APIService.fetchWithRx(url: url, retries: 2)
            .map { data -> [MovieListResult] in
                let response = try! JSONDecoder().decode(MovieList.self, from: data)
                self.listTitleObaservable.onNext(category.title)
                return response.results
            }.map { return $0.map { return MovieFront.convertFromMovieInfo(movie: $0) } }
            .take(1)
            .debug()
            .bind(to: movieFrontObservable)
    }
}
