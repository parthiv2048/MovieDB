//
//  MockNetworkManager.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 2/17/26.
//

import UIKit

class MockNetworkManager: NetworkManagerProtocol {
    static let shared = MockNetworkManager()
    
    private init() {}
    
    func fetchMovies(_ moviesListURL: String?) async -> [MovieData] {
        guard let uwURL = moviesListURL, let serverURL = URL(string: uwURL) else {
            print("Log: Invalid URL")
            return []
        }
        
        var moviesArr: [MovieData] = []
        
        moviesArr.append(
            MovieData(
                overview: "This is the first test movie",
                title: "Test Movie 1"
            )
        )
        
        moviesArr.append(
            MovieData(
                overview: "This is the second test movie",
                title: "Test Movie 2"
            )
        )
        
        return moviesArr
    }
}

