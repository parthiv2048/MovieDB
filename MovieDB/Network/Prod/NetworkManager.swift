//
//  NetworkManager.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 2/4/26.
//

import UIKit

class NetworkManager: NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMovies(_ moviesListURL: String?) async -> [MovieData] {
        guard let uwURL = moviesListURL, let serverURL = URL(string: uwURL) else {
            print("Log: Invalid URL")
            return []
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: serverURL)
            
            if let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode != 200 {
                print("Log: No data received from server, status code: \(serverResponse.statusCode)")
                return []
            }
            
            let movieListResult = try? JSONDecoder().decode(MovieListResult.self, from: data)
            return movieListResult?.results ?? []
        } catch {
            print("Log: Error fetching data from server")
            return []
        }
    }
}

