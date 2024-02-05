//
//  MoviesListVC.swift
//  Movies
//
//  Created by Admin on 01.02.2024.
//

import UIKit

class MoviesListVC: UIViewController, UICollectionViewDelegate {

    enum Section {
        case main
    }
    
    var movies: [Movie] = []
    var movieId: Int = 0
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getMovies()
        configureDataSource()
        collectionView.delegate = self
        longTapRecog()
    }
    
    func longTapRecog() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(addToFavorites))
        collectionView.addGestureRecognizer(longTap)
    }

    @objc func addToFavorites(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        let touchPoint = gesture.location(in: collectionView)
        
        if let indexPath = collectionView.indexPathForItem(at: touchPoint) {
            let selectedMovie = movies[indexPath.item]
            movieId = selectedMovie.id
            print("Long tap recognized for movie with id: \(movieId)")
        }
        
        NetworkManager.shared.getMovieDetails(for: movieId) {
            [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movie):
                let favorite = Movie(id: movie.id, title: movie.title, poster_path: movie.poster_path)
                
                PresistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "", message: "Movie added to Favorites", buttonTitle: "Ok")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something get wrong when use long tap", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    func createColumnFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            flowLayout.itemSize = CGSize(width: view.bounds.width - 24, height: view.bounds.width / 2 + 200)
            flowLayout.minimumLineSpacing = 10
            return flowLayout
    }
    
    func getMovies() {
        NetworkManager.shared.getListOfMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                self.movies = movies.results
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "No movies", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.set(movie: movie)
            return cell
        })
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        
        let destVC = MovieInfoVC()
        destVC.movieId = movie.id
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}
