//
//  MockService.swift
//  ProyectoTestTests
//
//  Created by Patricio Tovar on 7/10/22.
//

@testable import ProyectoTest
import Foundation

class MockService : Services{
    
    var movie = Movie(id: 1, title: "Fake", overview: "Strong", vote_average: 10, vote_count: 10, tagline: "Test", videos: nil)
    
    var movies: [Movie] = []
    func get<T>(pageNumber: Int, callback: @escaping (T) -> Void) where T : Decodable, T : Encodable {
      //  callback(MoviesResponse() as! T)
        var moviesResponse:MoviesResponse!
        for i in 1...20 {
            movie.id = i
            movies.append(movie)
        }
        moviesResponse = MoviesResponse(results: movies)
        callback(moviesResponse as! T)
    }
    
    func getMovie<T>(idMovie: Int, callback: @escaping (T) -> Void) where T : Decodable, T : Encodable {
        movie.id = idMovie
        callback(movie as! T)
    }
    
    

    
    
    
}
