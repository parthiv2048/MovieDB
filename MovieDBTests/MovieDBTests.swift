//
//  MovieDBTests.swift
//  MovieDBTests
//
//  Created by Parthiv Ganguly on 1/26/26.
//

import XCTest
@testable import MovieDB

final class MovieDBTests: XCTestCase {
    
    private var objMovieDetailsViewModelEmpty: MovieDetailsViewModel?

    override func setUpWithError() throws {
        objMovieDetailsViewModelEmpty = MovieDetailsViewModel()
    }

    override func tearDownWithError() throws {
    }
    
    func testGetPosterImage() {
        let result = objMovieDetailsViewModelEmpty?.getPosterImage()
        XCTAssertNil(result)
    }
    
    func testGetTitle() {
        let result = objMovieDetailsViewModelEmpty?.getTitle()
        XCTAssertNil(result)
    }
    
    func testGetDescription() {
        let result = objMovieDetailsViewModelEmpty?.getDescription()
        XCTAssertNil(result)
    }
    
    func testGetPopularityScore() {
        let result = objMovieDetailsViewModelEmpty?.getPopularityScore()
        XCTAssertNil(result)
    }
    
    func testGetVoteAverage() {
        let result = objMovieDetailsViewModelEmpty?.getVoteAverage()
        XCTAssertNil(result)
    }
    
    func testGetReleaseDate() {
        let result = objMovieDetailsViewModelEmpty?.getReleaseDate()
        XCTAssertNil(result)
    }
    
    func testGetVoteCount() {
        let result = objMovieDetailsViewModelEmpty?.getVoteCount()
        XCTAssertNil(result)
    }
    
    func testGetGenreIDs() {
        let result = objMovieDetailsViewModelEmpty?.getGenreIDs()
        XCTAssertNil(result)
    }
}
