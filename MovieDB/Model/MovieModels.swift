//
//  MovieData.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 1/26/26.
//

struct MovieListResult: Decodable {
    var page: Int?
    var results: [MovieData]?
}

struct MovieData: Decodable {
    var adult: Bool?
    var backdropImage: String?
    var genreIDArr: [Int]?
    var id: Int?
    var language: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterImage: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropImage = "backdrop_path"
        case genreIDArr = "genre_ids"
        case id
        case language = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterImage = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
