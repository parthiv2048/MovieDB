//
//  Constants.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 1/26/26.
//

import UIKit

// MARK: - IDs for View Controllers

enum ViewControllerIdentifiers: String {
    case MovieListVC = "MovieListVC"
    case MovieDetailsVC = "MovieDetailsVC"
}

// MARK: - IDs for Custom Views

enum ViewIdentifiers: String {
    case MovieListTableViewCell = "MovieListTableViewCell"
}

// MARK: - Colors for UI Components

enum ColorConstants {
    case viewBackgroundColor
    case cellBackgroundColor
    case movieListBackgroundColor
    
    var getColor: UIColor {
        switch self {
        case .viewBackgroundColor:
            UIColor(hue: 200/360.0, saturation: 100/100.0, brightness: 40/100.0, alpha: 1)
        case .cellBackgroundColor:
            UIColor(hue: 200/360.0, saturation: 100/100.0, brightness: 10/100.0, alpha: 1)
        case .movieListBackgroundColor:
            UIColor(hue: 60/360.0, saturation: 13/100.0, brightness: 94/100.0, alpha: 1)
        }
    }
}

// MARK: - Constraint Constants

enum ConstraintConstants: Double {
    case movieListTableViewRowHeight = 140.0
    case posterImageWidth = 120.0
}

// MARK: - Server Endpoints

enum Server: String {
    case moviesList = "https://api.themoviedb.org/3/discover/movie?api_key=c91ed3a7a344459eccad9687acf0d07e"
    case imageBasePath = "https://image.tmdb.org/t/p/w500"
}

// MARK: - Service Constants

enum ServiceConstants: String {
    case auth = "com.moviedb.auth"
}

// MARK: - User Defaults Keys

enum UserDefaultsKeys: String {
    case rememberUsername = "rememberUsername"
    case username = "username"
}
