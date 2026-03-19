//
//  ImageManager.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 3/19/26.
//

import UIKit

enum ImageError: Error {
    case apiError
    case decodingError
}

actor ImageManager {
    /// Using Singleton pattern for shared instance of ImageManager (and shared image cache)
    static let shared = ImageManager()
    
    private var imageCache = NSCache<NSURL, UIImage>()
    
    private init() {
        /// Count limit is 50 images and memory limit is 100 MB
        imageCache.countLimit = 50
        imageCache.totalCostLimit = 100 * 1024 * 1024
    }
    
    func fetchImage(for url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> Void) async {
        let imageCacheKey = url as NSURL
        
        /// Try to fetch image from cache
        if let retrievedImage = imageCache.object(forKey: imageCacheKey) {
            print("Using cached image")
            completionHandler(.success(retrievedImage))
            return
        }
        
        print("Fetching image from network")
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            /// Return API Error if reponse code is not 200
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completionHandler(.failure(ImageError.apiError))
                return
            }
            
            /// Return Decoding Error if data can't be converted to UIImage
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(ImageError.decodingError))
                return
            }
            
            /// Store image in cache
            imageCache.setObject(image, forKey: imageCacheKey)
            completionHandler(.success(image))
        } catch {
            completionHandler(.failure(error))
        }
    }
}
