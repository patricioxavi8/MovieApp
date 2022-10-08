//
//  Movie.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 5/10/22.
//

import Foundation

struct Movie: Codable {
    var id: Int
    let title: String
    let overview: String
    var poster_path: String?
    var release_date: String?
    let vote_average: Double?
    let vote_count: Int?
    var backdrop_path: String?
    var runtime: Int?
    var genres: [Genres]?
    let tagline: String?
    let videos: MovieVideoResponse?
    
    
    
    func releaseYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        if let release_date = release_date , let dateFromString = dateFormatter.date(from: release_date) {
          
            dateFormatter.dateFormat = "yyy"
            return dateFormatter.string(from: dateFromString)
        }
        return nil
    }
    
    
    
    
    
}


struct MoviesResponse: Codable {
    var results: [Movie]?
    
    
}

struct Genres: Codable {
    
    let id:Int
    var name: String?
}
struct MovieVideoResponse: Codable {
    let results: [MovieVideo]
}

struct MovieVideo: Codable{
    let id: String
    let key: String
    let name: String
    let site: String
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
}
