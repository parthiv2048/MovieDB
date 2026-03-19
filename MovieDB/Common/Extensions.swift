//
//  Extensions.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 1/26/26.
//
import UIKit

// MARK: - Navigation Methods

extension UIViewController {
    func navigateToMovieDetails(movieData: MovieData?) {
        let objMovieDetailsVC = MovieDetailsVC(movieDetailsViewModel: MovieDetailsViewModel(movie: movieData))
        self.navigationController?.pushViewController(objMovieDetailsVC, animated: true)
    }
    
    func navigateToMovieListView() {
        let objMovieListViewModel = MovieListViewModel(service: NetworkManager.shared)
        let objMovieListVC = MovieListVC(movieListViewModel: objMovieListViewModel)
        self.navigationController?.pushViewController(objMovieListVC, animated: true)
    }
    
    func navigateToSignup() {
        let objSignupVM = SignupViewModel()
        let objSignupVC = SignupVC(signupViewModel: objSignupVM)
        self.navigationController?.pushViewController(objSignupVC, animated: true)
    }
}

// MARK: - Show Alert Method

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UI Methods

extension UIView {
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
}

// MARK: - Image Loading Method

extension UIImageView {
    func loadImage(url: String) async {
        let backupImage = UIImage(systemName: "photo")
        
        guard let serverURL = URL(string: url) else {
            print("Invalid URL")
            self.image = backupImage
            return
        }
        
        var image: UIImage?
        
        await ImageManager.shared.fetchImage(for: serverURL) { result in
            switch result {
            case .success(let retrievedImage):
                image = retrievedImage
            case .failure(let error):
                image = backupImage
                print(error)
            }
        }
        
        await MainActor.run { self.image = image }
    }
}
