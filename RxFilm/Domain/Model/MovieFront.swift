//
//  MovieFront.swift
//  RxFilm
//
//  Created by AnılKaramış on 22.06.2024.
//

import Foundation

struct MovieFront {
    let id: Int
    let title: String
    let posterPath: String?
    let genre: String
    let releaseDate: String
    let ratingScore: Double
    let ratingCount: Int
}

extension MovieFront{
    static func convertFromMovieInfo(movie: MovieListResult) -> MovieFront {
        let genreValue: String = (movie.genreIDS.count > 0) ? genreCode[movie.genreIDS[0]] ?? "" : ""
        
        return MovieFront(id: movie.id, title: movie.title, posterPath: movie.posterPath, genre: genreValue, releaseDate: movie.releaseDate, ratingScore: movie.voteAverage, ratingCount: movie.voteCount)
    }
}
