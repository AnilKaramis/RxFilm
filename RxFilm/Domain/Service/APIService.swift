//
//  APIService.swift
//  RxFilm
//
//  Created by AnılKaramış on 22.06.2024.
//

import Foundation
import RxSwift

// TODO: - Make this layer to generic

class APIService {
    
    ///Insert api
    static func configureUrlString(category: MovieListCategory, language: Language, page: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(category.key)?api_key=\(Network.APIKey)&language=\(language.key)&page=\(page)"
    }
    
    static func fetchRequest(url: String,retries:Int,onComlete: @escaping(Result<Data, Error>) ->Void) {
        
        guard let url = URL(string: url) else { return }
        
        let task = URLSession(configuration: .default).dataTask(with: url) { data, response, error in
            if let error = error {
                onComlete(.failure(error))
                return
            }
            guard let safeData = data else {
                let httpResponse = response as? HTTPURLResponse
                onComlete(.failure(NSError(domain: "", code: httpResponse?.statusCode ?? 0, userInfo: nil)))
                return
            }
            onComlete(.success(safeData))
        }
        task.resume()
    }
}
//MARK: - Fetch with Rx

extension APIService {
    
    static func fetchWithRx(url: String, retries: Int) -> Observable<Data> {
        return Observable.create { emitter in
            
            fetchRequest(url: url, retries: retries) { result in
                switch result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}

enum MovieListCategory {
    case Popular, Upcoming, TopRated,NowPlaying
    
    var key: String {
        switch self {
        case.Popular: return "popular"
        case.Upcoming: return "upcoming"
        case.TopRated: return"top_rated"
        case .NowPlaying: return "now_playing"
        }
    }
}

enum Language {
    
    case Turkish, English
    
    var key: String {
        switch self{
        case .English: return "en-US"
        case .Turkish: return "tu-TR"
        }
    }
}






//    let session = URLSession(configuration: .default) /// .epheral bellek uzerinde bulunan cerezleri oturum sonalndirildiginda siler.
//    func fetchData() {
//        var completeURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=9c070ed6542142b55eb044440c144360&language=en-US&page=1"
//
//        let retyLimit = 2
//
//
//    }
//    private func performRequest(url:String, retries: Int) {
//
//        guard let UrlTask = URL(string: url) else {return}
//
//        let task = session.dataTask(with: UrlTask) {[self] (data, response, error) in
//
//            if error != nil {
//                print(error!)
//                return
//            }
//            guard let safeData = data else {return}
//
//            //Decode JSON
//            do {
//                let result = try JSONDecoder().decode(MovieList.self, from: safeData)
//            }catch {
//                print(error)
//                if retries > 0 {
//                    print("\(retries) retries remaining... Retrying")
//                    performRequest(url: url, retries: retries-1)
//                } else {
//                    print("\(retries) retries remaining... Exit with failure")
//                    return
//                }
//            }
//        }
//        task.resume()
//    }
//}
