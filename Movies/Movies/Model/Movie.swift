//
//  Movie.swift
//  Movies
//
//  Created by Admin on 02.02.2024.
//

import Foundation

struct ListOfMovies: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable, Hashable {
    let id: Int
    let title: String
    let poster_path: String
}
