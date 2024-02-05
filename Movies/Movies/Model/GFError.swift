//
//  ErrorMessage.swift
//  Movies
//
//  Created by Admin on 03.02.2024.
//

import Foundation

enum GFError: String, Error {
    case noData = "Data not received"
    case notDecode = "Data not decode"
    case unableToFavorite = "Movie dont added to favorites"
    case alreadyInFavorites = "Movie already added to favorites"
}
