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
    let posterPath: String
    
    let genre: String
    let releaseDate: String
    let ratingScore: Double
    let ratingCount: Int
}

extension MovieFront{
    static func convertFromMovieInfo(movie: MovieListResult) -> MovieFront {
        return MovieFront(id: movie.id, title: movie.title, posterPath: "https://image.tmdb.org/t/p/original/\(movie.posterPath)", genre: genreCode[movie.genreIDS[0]] ?? "", releaseDate: movie.releaseDate, ratingScore: movie.voteAverage, ratingCount: movie.voteCount)
    }
}
