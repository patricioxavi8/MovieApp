//
//  Constants.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 5/10/22.
//

import Foundation

struct Constants {
    static let API_KEY = "e7631ffcb8e766993e5ec0c1f4245f93"
    static let BASE_URL = "https://api.themoviedb.org/3/movie/popular"
    static let FULL_URL = BASE_URL + "?api_key=" + API_KEY
    static let MOVIE_SEARCH_BASE_URL = "https://api.themoviedb.org/3/movie/"
    static let IMAGES_BASE_URL = "https://image.tmdb.org/t/p/"
    static let BACK_DROP_BASE_URL = IMAGES_BASE_URL + "w500"
    static let POSTER_BASE_URL = IMAGES_BASE_URL + "w185"
   
}

