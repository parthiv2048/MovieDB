//
//  MovieListCollectionViewCell.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 2/3/26.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private var containerView: UIView?
    private var titleLabel: UILabel?
    private var popularityScoreLabel: UILabel?
    private var releaseYearLabel: UILabel?
    private var posterImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createInitialCellDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createInitialCellDesign() {
        contentView.backgroundColor = ColorConstants.cellBackgroundColor.getColor
        contentView.layer.cornerRadius = 10
        
        containerView = UIView()
        containerView?.layer.cornerRadius = 10
        containerView?.backgroundColor = ColorConstants.cellBackgroundColor.getColor
        containerView?.translatesAutoresizingMaskIntoConstraints = false
        
        /// Create label for Movie Title
        titleLabel = UILabel()
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel?.numberOfLines = 0
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = .white
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        /// Create label for Popularity Score
        popularityScoreLabel = UILabel()
        popularityScoreLabel?.font = UIFont.systemFont(ofSize: 15)
        popularityScoreLabel?.numberOfLines = 0
        popularityScoreLabel?.textAlignment = .center
        popularityScoreLabel?.textColor = .white
        popularityScoreLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        /// Create label for Release Year of movie
        releaseYearLabel = UILabel()
        releaseYearLabel?.font = UIFont.systemFont(ofSize: 15)
        releaseYearLabel?.numberOfLines = 0
        releaseYearLabel?.textAlignment = .center
        releaseYearLabel?.textColor = .white
        releaseYearLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        /// Create Image View for Movie Poster
        posterImageView = UIImageView()
        posterImageView?.layer.cornerRadius = 8
        posterImageView?.clipsToBounds = true
        posterImageView?.translatesAutoresizingMaskIntoConstraints = false
        
        if let containerView = containerView, let titleLabel = titleLabel, let popularityScoreLabel = popularityScoreLabel, let releaseYearLabel = releaseYearLabel, let posterImageView = posterImageView {
            contentView.addSubview(containerView)
            containerView.addSubview(titleLabel)
            containerView.addSubview(popularityScoreLabel)
            containerView.addSubview(releaseYearLabel)
            containerView.addSubview(posterImageView)
            
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
                posterImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                posterImageView.widthAnchor.constraint(equalToConstant: ConstraintConstants.posterImageWidth.rawValue),
                posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.4),
                
                titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
                titleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.85),
                
                popularityScoreLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
                popularityScoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                popularityScoreLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
                
                releaseYearLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
                releaseYearLabel.topAnchor.constraint(equalTo: popularityScoreLabel.bottomAnchor, constant: 10),
                releaseYearLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
                releaseYearLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            ])
        }
    }
    
    // MARK: Add Movie Details to Collection View Cell
    
    func setUpMovieDetails(movieData: MovieData?) {
        titleLabel?.text = "\(movieData?.title ?? "")"
        popularityScoreLabel?.text = "Pop. Score: \(movieData?.popularity ?? 0)"
        releaseYearLabel?.text = "Release: \(movieData?.releaseDate ?? "")"
        if let posterImage = movieData?.posterImage {
            Task {
                await posterImageView?.loadImage(url: APIEndpoints.imageBasePath.rawValue + posterImage)
            }
        } else {
            posterImageView?.image = UIImage(systemName: "movieclapper.fill")
        }
    }
}
