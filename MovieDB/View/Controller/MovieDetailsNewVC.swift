//
//  MovieDetailsNewVC.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 2/5/26.
//

import UIKit

class MovieDetailsNewVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(MovieOverviewTableViewCell.self, forCellReuseIdentifier: "MovieOverviewTableViewCell")
        tv.register(MovieRatingsTableViewCell.self, forCellReuseIdentifier: "MovieRatingsTableViewCell")
        tv.register(DescriptionTableViewCell.self, forCellReuseIdentifier: "DescriptionTableViewCell")
        tv.showsVerticalScrollIndicator = false
        tv.estimatedRowHeight = UITableView.automaticDimension
        return tv
    }()
    
    lazy var navBar: CustomNavBar = {
        let v = CustomNavBar()
        v.controller = self
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.shadowRadius = 10
        v.layer.shadowColor = UIColor(white: 0, alpha: 0.1).cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = CGSize(width: 0, height: 10)
        return v
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var movieDetailsViewModel: MovieDetailsViewModelProtocol?
    
    init(movieDetailsViewModel: MovieDetailsViewModelProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.movieDetailsViewModel = movieDetailsViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorConstants.movieListBackgroundColor.getColor
        tableView.backgroundColor = ColorConstants.movieListBackgroundColor.getColor
        
        view.addSubview(tableView)
        view.addSubview(navBar)
        tableView.pin(to: view)
        
        let headerView = StrechyHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250))
        if let posterImage = movieDetailsViewModel?.getPosterImage() {
            Task {
                await headerView.imageView.loadImage(url: Server.imageBasePath.rawValue + posterImage)
            }
        } else {
            headerView.imageView.image = UIImage(systemName: "photo")
        }
        self.tableView.tableHeaderView = headerView
        navBar.alpha = 0
    }
}

extension MovieDetailsNewVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieOverviewTableViewCell", for: indexPath) as! MovieOverviewTableViewCell
            cell.addMovieTitle(title: movieDetailsViewModel?.getTitle())
            cell.backgroundColor = ColorConstants.movieListBackgroundColor.getColor
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieRatingsTableViewCell", for: indexPath) as! MovieRatingsTableViewCell
            cell.addMovieRating(voteAverage: movieDetailsViewModel?.getVoteAverage(), voteCount: movieDetailsViewModel?.getVoteCount())
            cell.backgroundColor = ColorConstants.movieListBackgroundColor.getColor
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            cell.addDescription(description: movieDetailsViewModel?.getDescription())
            cell.backgroundColor = ColorConstants.movieListBackgroundColor.getColor
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! StrechyHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
        
        let y = scrollView.contentOffset.y
        let v = y/210
        let value = Double(round(100*v)/100)
        
        if value >= 1.0 {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
                self.navBar.alpha = 1
            }, completion: nil)
            
            UIView.animate(withDuration: 0.4) {
                self.navBar.gameThumbImage.transform = CGAffineTransform(translationX: 0, y: 0)
                self.navBar.getButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
                self.navBar.alpha = 0
            }, completion: nil)
            
            UIView.animate(withDuration: 0.4) {
                self.navBar.gameThumbImage.transform = CGAffineTransform(translationX: 0, y: +50)
                self.navBar.getButton.transform = CGAffineTransform(translationX: 0, y: +50)
            }
        }
    }
}
