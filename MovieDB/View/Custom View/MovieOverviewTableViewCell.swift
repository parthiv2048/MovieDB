//
//  MovieOverviewTableViewCell.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 2/5/26.
//

import UIKit

class MovieOverviewTableViewCell: UITableViewCell {
    
    let movieTitle:UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    let streamButton:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 17.5
        btn.backgroundColor = UIColor.systemBlue
        btn.setTitle("Stream Movie", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(movieTitle)
        addSubview(streamButton)
        setUpConstraints()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            movieTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            movieTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            
            streamButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            streamButton.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 15),
            streamButton.widthAnchor.constraint(equalToConstant: 200),
            streamButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
        ])
    }
    
    func addMovieTitle(title: String?) {
        let attributedText = NSMutableAttributedString(string: title ?? "", attributes:[NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)])
        movieTitle.attributedText = attributedText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
