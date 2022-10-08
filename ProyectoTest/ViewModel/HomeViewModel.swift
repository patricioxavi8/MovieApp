//
//  HomeModelView.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 4/10/22.
//

import Foundation

class HomeViewModel : HomeViewModelProtocol {
    
    private var _apiService : Services!
    var _movies: [Any] = []
    var pageNumber: Int
    
    init(apiService:Services) {
        self._apiService = apiService
        self.pageNumber = 1
    }
    
    
    func get<T>(pageNumber:Int, callback: @escaping (T) -> Void) {
        
        _apiService.get(pageNumber: pageNumber) { [weak self] (list: MoviesResponse) in
            if let movieList = list.results {
                self?._movies = movieList
                callback(list as! T)
            }
        }
    }
    
}
