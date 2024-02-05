//
//  FavoriteCell.swift
//  Movies
//
//  Created by Admin on 05.02.2024.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavortieCell"
    
    let posterImageView = GFPosterImageView(frame: .zero)
    let movieTitleLabel = GFTitleLabel(textAlignment: .left, fontSize: 18)
    
    let posterWidth: CGFloat = 110
    static let posterHeight: CGFloat = 160

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Movie) {
        movieTitleLabel.text = favorite.title
        let posterPath = "https://image.tmdb.org/t/p/w500/\(favorite.poster_path)"
        posterImageView.downloadImage(from: posterPath)
    }
    
    private func configure() {
        addSubview(posterImageView)
        addSubview(movieTitleLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            posterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: FavoriteCell.posterHeight),
            posterImageView.widthAnchor.constraint(equalToConstant: posterWidth),
            
            movieTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 24),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
