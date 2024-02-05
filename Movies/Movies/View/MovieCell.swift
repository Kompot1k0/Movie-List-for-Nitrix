//
//  MovieCell.swift
//  Movies
//
//  Created by Admin on 03.02.2024.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseID = "MovieCell"
    
    let posterImageView = GFPosterImageView(frame: .zero)
    let movieTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    
    let posterWidth: CGFloat = 220
    let posterHeight: CGFloat = 320
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: Movie) {
        movieTitleLabel.text = movie.title
        let posterPath = "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"
        posterImageView.downloadImage(from: posterPath)
    }
    
    private func configure() {
        addSubview(posterImageView)
        addSubview(movieTitleLabel)
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterImageView.heightAnchor.constraint(equalToConstant: posterHeight),
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            movieTitleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            movieTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            movieTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -padding)
        ])
    }
}
