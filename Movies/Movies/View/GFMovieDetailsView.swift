//
//  GFMovieDetailsView.swift
//  Movies
//
//  Created by Admin on 04.02.2024.
//

import UIKit

class GFMovieDetailsView: UIViewController {
    let posterImageView = GFPosterImageView(frame: .zero)
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 20)
    let yearLable = GFSecondaryTitleLable(fontSize: 16)
    let genresLabel = GFSecondaryTitleLable(fontSize: 16)
    let overviewLabel = GFBodyLabel(textAlignment: .left)
    
    let posterWidth: CGFloat = 180
    let posterHeight: CGFloat = 270
    
    var movieDetails: MovieDetails!

    
    init(movieDetails: MovieDetails!) {
        super.init(nibName: nil, bundle: nil)
        self.movieDetails = movieDetails
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        layoutUI()
        configureUIElement()
    }
    
    func configureUIElement() {
        let posterPath = "https://image.tmdb.org/t/p/w500/\(movieDetails.poster_path)"
        posterImageView.downloadImage(from: posterPath)
        titleLabel.text = movieDetails.title
        yearLable.text = movieDetails.release_date.convertToDisplayFormat()
        overviewLabel.text = movieDetails.overview
        genresLabel.text = getGenres()
    }
    
    func getGenres() -> String {
        var genresString = ""
        for genre in movieDetails.genres {
            if !genresString.isEmpty {
                genresString += ", "
            }
            genresString += genre.name
        }
        return genresString
    }
    
    func addSubview() {
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(yearLable)
        view.addSubview(genresLabel)
        view.addSubview(overviewLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 10
        let textImagePadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            posterImageView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterImageView.heightAnchor.constraint(equalToConstant: posterHeight),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: textImagePadding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 90),
            
            yearLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            yearLable.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: textImagePadding),
            yearLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            yearLable.heightAnchor.constraint(equalToConstant: 20),
            
            genresLabel.topAnchor.constraint(equalTo: yearLable.bottomAnchor, constant: 8),
            genresLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: textImagePadding),
            genresLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            genresLabel.heightAnchor.constraint(equalToConstant: 20),
            
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: textImagePadding),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            overviewLabel.bottomAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: -padding)
            
        ])
    }
}
