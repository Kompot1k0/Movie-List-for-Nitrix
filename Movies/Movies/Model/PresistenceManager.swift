//
//  PresistenceManager.swift
//  Movies
//
//  Created by Admin on 04.02.2024.
//

import Foundation

enum PresistenceActionType {
    case add, remove
}

enum PresistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Movie, actionType: PresistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case.success(let favorites):
                var retrieveFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrieveFavorites.contains(where: { $0.id == favorite.id }) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    retrieveFavorites.append(favorite)
                            
                            
                case .remove:
                    retrieveFavorites.removeAll { $0.id == favorite.id }
                }
                
                completed(save(favorites: retrieveFavorites))
                
            case .failure(let error):
                completed(error)
            }
            
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result <[Movie], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Movie].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Movie]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
