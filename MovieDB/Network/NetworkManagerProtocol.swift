//
//  NetworkManagerProtocol.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 3/13/26.
//

protocol NetworkManagerProtocol {
    func fetchMovies(_ moviesListURL: String?) async -> [MovieData]
}
