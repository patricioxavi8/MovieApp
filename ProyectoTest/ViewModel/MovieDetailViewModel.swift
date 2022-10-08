//
//  MovieDetailViewModel.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 5/10/22.
//

import Foundation
import UIKit
class MovieDetailViewModel : MovieDetailViewModelProtocol {
    
    
    private var _apiService : Services!
    var _movie:Movie!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    init(apiService:Services) {
        
        self._apiService = apiService
    }
    
    
    
    func getMovie<T>(idMovie: Int, callback: @escaping (T) -> Void) where T : Decodable, T : Encodable {
        
        _apiService.getMovie(idMovie: idMovie) {
            [weak self] (movie:Movie) in
            
            self?._movie = movie
            if let fullBackdropPath = movie.backdrop_path {
                self?._movie.backdrop_path = "\(Constants.BACK_DROP_BASE_URL)\(fullBackdropPath)"
            }
            if let posterBackdropPath = movie.poster_path {
                self?._movie.poster_path = "\(Constants.POSTER_BASE_URL)\(posterBackdropPath)"
            }
            self!.saveVisitedMovie()
            callback(self?._movie   as! T)
            
            
        }
        
    }
    
    func saveVisitedMovie(){
        if !checkIfMovieExists() {
            let newMovie = MovieVisited(context: context)
            newMovie.id = Int32(self._movie.id)
            newMovie.overview = self._movie.overview
            newMovie.title = self._movie.title
            newMovie.vote_average = self._movie.vote_average!
            
            do {
                try context.save()
            }catch{
                print("Error To Save Movie")
            }
        }
        
    }
    
    
    func checkIfMovieExists() -> Bool{
      
        let fetchRequest = MovieVisited.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(
            format: "id == %i", Int32(self._movie.id)
        )
        
        do {
            let objects = try context.fetch(fetchRequest)
            if objects.isEmpty {
                return false
            }
            return true
        }catch{
            print("error al traer objeto")
        }
        return true
    }
    
    
    
    
    
}
