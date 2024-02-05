//
//  MovieDetails.swift
//  Movies
//
//  Created by Admin on 02.02.2024.
//

import Foundation

struct MovieDetails: Codable {
    let id: Int
    let overview: String
    let poster_path: String
    let release_date: String
    let title: String
    let genres: [MovieGenres]
}

struct MovieGenres: Codable {
    let id: Int
    let name: String
}
