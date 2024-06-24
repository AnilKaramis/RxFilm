//
//  APIService.swift
//  RxFilm
//
//  Created by AnılKaramış on 22.06.2024.
//

import Foundation
import RxSwift

class APIService {
    
    let session = URLSession(configuration: .default) /// .epheral bellek uzerinde bulunan cerezleri oturum sonalndirildiginda siler.
    func fetchData() {
        var completeURL = "https://api.themoviedb.org/3/movie/upcoming?api_key=9c070ed6542142b55eb044440c144360&language=en-US&page=1"

        let retyLimit = 2
        
        
    }
    private func performRequest(url:String, retries: Int) {
        
        guard let UrlTask = URL(string: url) else {return}
        
        let task = session.dataTask(with: UrlTask) {[self] (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            guard let safeData = data else {return}
            
            //Decode JSON
            do {
                let result = try JSONDecoder().decode(MovieList.self, from: safeData)
            }catch {
                print(error)
                if retries > 0 {
                    print("\(retries) retries remaining... Retrying")
                    performRequest(url: url, retries: retries-1)
                } else {
                    print("\(retries) retries remaining... Exit with failure")
                    return
                }
            }
        }
        task.resume()
    }
}
