//
//  MovieDetailViewModelProtocol.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 5/10/22.
//

import Foundation
protocol MovieDetailViewModelProtocol {
    
    
    func getMovie<T: Codable>(idMovie: Int, callback: @escaping (T) -> Void)
    
}
