//
//  ViewController+TableView.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 6/10/22.
//



import Foundation
import UIKit

extension ViewController : UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return _searchedMovies.count
        }
        return _movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieTableViewCell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier,
                                                                    for: indexPath) as! MovieTableViewCell
        
        let movie:Movie
        if searching {
            movie = self._searchedMovies[indexPath.row]
        }else
        {
            movie = self._movies[indexPath.row]
        }
        
        cell.configureCell(movie: movie)
        
        return cell
    }
    
    
}


extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailsViewController(indexPath: indexPath)
    }
}
