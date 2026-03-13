//
//  MovieListCollectionViewVC.swift
//  MovieDB
//
//  Created by Parthiv Ganguly on 2/3/26.
//

import UIKit

class MovieListVC: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var movieListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width / 2 - 20, height: 300)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let movieListCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        movieListCollectionView.dataSource = self
        movieListCollectionView.delegate = self
        movieListCollectionView.backgroundColor = ColorConstants.movieListBackgroundColor.getColor
        movieListCollectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        movieListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return movieListCollectionView
    }()
    
    private var movieHeaderLabel: UILabel = {
        let movieHeaderLabel = UILabel()
        movieHeaderLabel.text = "Movies"
        movieHeaderLabel.font = UIFont.boldSystemFont(ofSize: 30)
        movieHeaderLabel.textColor = .white
        movieHeaderLabel.textAlignment = .center
        movieHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return movieHeaderLabel
    }()
    
    private let internetToggleLabel: UILabel = {
        let internetToggleLabel = UILabel()
        internetToggleLabel.text = "Disable Internet"
        internetToggleLabel.textColor = .white
        internetToggleLabel.font = .systemFont(ofSize: 16)
        internetToggleLabel.translatesAutoresizingMaskIntoConstraints = false
        return internetToggleLabel
    }()

    private let internetToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
        
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = ColorConstants.viewBackgroundColor.getColor
        searchBar.placeholder = "Search movie title"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    // MARK: - Properties (View Model)
    
    private var movieListViewModel: MovieListViewModelProtocol?
    
    // MARK: - Initializer (Injection)
    
    init(movieListViewModel: MovieListViewModelProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.movieListViewModel = movieListViewModel
        
        Task {
            await fetchMovies()
        }
    }
    
    private func fetchMovies() async {
        await self.movieListViewModel?.fetchMovies()
        movieListCollectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()
    }
    
    // MARK: - Set Up Screen
    
    private func setUpScreen() {
        view.backgroundColor = ColorConstants.viewBackgroundColor.getColor
        searchBar.delegate = self
        internetToggle.addTarget(self, action: #selector(internetToggleChanged(_:)), for: .valueChanged)
        
        view.addSubview(movieHeaderLabel)
        view.addSubview(internetToggle)
        view.addSubview(internetToggleLabel)
        view.addSubview(searchBar)
        view.addSubview(movieListCollectionView)
        
        NSLayoutConstraint.activate([
            internetToggle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            internetToggle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            internetToggleLabel.centerYAnchor.constraint(equalTo: internetToggle.centerYAnchor),
            internetToggleLabel.trailingAnchor.constraint(equalTo: internetToggle.leadingAnchor, constant: -15),
            
            movieHeaderLabel.topAnchor.constraint(equalTo: internetToggle.bottomAnchor, constant: 15),
            movieHeaderLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            searchBar.topAnchor.constraint(equalTo: movieHeaderLabel.bottomAnchor, constant: 15),
            searchBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            movieListCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            movieListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc private func internetToggleChanged(_ sender: UISwitch) {
        if sender.isOn {
            internetToggleLabel.text = "Disable Internet"
            movieListViewModel?.setService(service: NetworkManager.shared)
        } else {
            internetToggleLabel.text = "Enable Internet"
            movieListViewModel?.setService(service: MockNetworkManager.shared)
        }
        
        Task {
            await fetchMovies()
        }
    }
}

// MARK: - Collection View Data Source & Delegate Methods

extension MovieListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieListViewModel?.numberOfMovies() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = movieListCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? MovieListCollectionViewCell
        cell?.setUpMovieDetails(movieData: movieListViewModel?.movie(at: indexPath.item))
        
        return cell ?? UICollectionViewCell()
    }
}

extension MovieListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToMovieDetails(movieData: movieListViewModel?.movie(at: indexPath.item))
    }
}

// MARK: Search Bar Methods

extension MovieListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieListViewModel?.filterMovies(searchStr: searchText)
        movieListCollectionView.reloadData()
    }
}
