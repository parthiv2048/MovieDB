//
//  MovieRatingsTableViewCell.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 2/5/26.
//

import UIKit

class MovieRatingsTableViewCell: UITableViewCell {

    let ratings:UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        l.textColor = .darkGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let ratingCount:UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14, weight: .light)
        l.textColor = .darkGray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(ratings)
        addSubview(ratingCount)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            ratings.centerXAnchor.constraint(equalTo: centerXAnchor),
            ratings.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            ratingCount.centerXAnchor.constraint(equalTo: ratings.centerXAnchor),
            ratingCount.topAnchor.constraint(equalTo: ratings.bottomAnchor, constant: 2),
            ratingCount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    func addMovieRating(voteAverage: Double?, voteCount: Int?) {
        ratings.text = "Vote Average: \(voteAverage ?? 0)"
        ratingCount.text = "\(voteCount ?? 0)K Votes"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
