//
//  HomeViewModelProtocol.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 4/10/22.
//

import Foundation

protocol HomeViewModelProtocol {
    
    func get<T: Codable>(pageNumber:Int, callback: @escaping (T) -> Void)
    
}
