//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 2/3/26.
//

protocol MovieDetailsViewModelProtocol {
    func getPosterImage() -> String?
    func getTitle() -> String?
    func getDescription() -> String?
    func getPopularityScore() -> Double?
    func getVoteAverage() -> Double?
    func getReleaseDate() -> String?
    func getVoteCount() -> Int?
    func getGenreIDs() -> [Int]?
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    private var movie: MovieData?
    
    init(movie: MovieData? = nil) {
        self.movie = movie
    }
    
    func getPosterImage() -> String? {
        movie?.posterImage
    }
    
    func getTitle() -> String? {
        movie?.title
    }
    
    func getDescription() -> String? {
        movie?.overview
    }
    
    func getPopularityScore() -> Double? {
        movie?.popularity
    }
    
    func getVoteAverage() -> Double? {
        movie?.voteAverage
    }
    
    func getReleaseDate() -> String? {
        movie?.releaseDate
    }
    
    func getVoteCount() -> Int? {
        movie?.voteCount
    }
    
    func getGenreIDs() -> [Int]? {
        movie?.genreIDArr
    }
}

