//
//  MovieInfoVC.swift
//  Movies
//
//  Created by Admin on 04.02.2024.
//

import UIKit

class MovieInfoVC: UIViewController {

    let detailsView = UIView()
    var movieId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = cancelButton
        
        layoutUI()
        
        NetworkManager.shared.getMovieDetails(for: movieId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.add(childVC: GFMovieDetailsView(movieDetails: movie), to: self.detailsView)
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "No movie details", message: error.rawValue, buttonTitle: "Ok")
            }
        } 
    }

    func layoutUI() {
        view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
