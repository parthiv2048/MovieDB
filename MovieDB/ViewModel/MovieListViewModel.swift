//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 2/3/26.
//

import Foundation

protocol MovieListViewModelProtocol {
    func setService(service: NetworkManagerProtocol?)
    func fetchMovies() async
    func numberOfMovies() -> Int?
    func movie(at: Int) -> MovieData?
    func filterMovies(searchStr: String)
}

class MovieListViewModel: MovieListViewModelProtocol {
    private var movies: [MovieData]?
    private var filteredMovies: [MovieData]?
    private var service: NetworkManagerProtocol?
    
    init(service: NetworkManagerProtocol? = nil) {
        self.service = service
    }
    
    /// Setter injection for service
    func setService(service: NetworkManagerProtocol?) {
        self.service = service
    }
    
    func fetchMovies() async {
        let listURL = (APIBaseURL.listBaseURL?.absoluteString ?? "") + APIEndpoints.moviesList.rawValue
        self.movies = await service?.fetchMovies(listURL) ?? []
        self.filteredMovies = self.movies
    }
    
    func numberOfMovies() -> Int? {
        filteredMovies?.count
    }
    
    func movie(at: Int) -> MovieData? {
        filteredMovies?[at]
    }
    
    func filterMovies(searchStr: String) {
        if searchStr.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies?.filter { (movie: MovieData) -> Bool in
                return movie.title?.lowercased().contains(searchStr.lowercased()) ?? false
            }
        }
    }
}

