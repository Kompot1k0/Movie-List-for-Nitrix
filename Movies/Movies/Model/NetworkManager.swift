//
//  NetworkManager.swift
//  Movies
//
//  Created by Admin on 02.02.2024.
//

// Bearer from Nitrix: eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyY2NjOWZjYjNlODg2ZmNiNWY4MDAxNTQxODczNTA 5NSIsInN1YiI6IjY1Yjc0MTJiYTBiNjkwMDE3YmNlZjhmOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJ dLCJ2ZXJzaW9uIjoxfQ.Hhl93oP6hoKiYuXMis5VT-MVRfv1KZXhJjSncyCkhpw

//My Bearer: eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODFmNmM3YzhjNWQ3OGFjOWQ1OGNlODYxMzg3NzUxNSIsInN1YiI6IjY1YmJhNDhkZDdjZDA2MDE3YjUzZmFiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ULKczqlva8l0Y7rDmMxTOJc5OsVl9SFbhbpN_tpe3Z0

import UIKit

class NetworkManager {
   static let shared = NetworkManager()
   let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getListOfMovies(completion: @escaping(Result<ListOfMovies, GFError>) -> Void) {
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODFmNmM3YzhjNWQ3OGFjOWQ1OGNlODYxMzg3NzUxNSIsInN1YiI6IjY1YmJhNDhkZDdjZDA2MDE3YjUzZmFiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ULKczqlva8l0Y7rDmMxTOJc5OsVl9SFbhbpN_tpe3Z0"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
          }
            guard let receivedData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(ListOfMovies.self, from: receivedData)
                print (movies)
                completion(.success(movies))
            } catch {
                completion(.failure(.notDecode))
            }
        })
        dataTask.resume()
    }
    
    
    
    func getMovieDetails(for movieId: Int, completion: @escaping(Result<MovieDetails, GFError>) -> Void) {
        let headers = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxODFmNmM3YzhjNWQ3OGFjOWQ1OGNlODYxMzg3NzUxNSIsInN1YiI6IjY1YmJhNDhkZDdjZDA2MDE3YjUzZmFiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ULKczqlva8l0Y7rDmMxTOJc5OsVl9SFbhbpN_tpe3Z0"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/\(movieId)?language=en-US")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
          }
            guard let receivedData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(MovieDetails.self, from: receivedData)
                completion(.success(movie))
            } catch {
                completion(.failure(.notDecode))
            }
        })
        dataTask.resume()
    }
}
