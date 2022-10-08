//
//  ApiService.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 4/10/22.
//

import Foundation

protocol Services{
    
    func get<T: Codable>(pageNumber:Int, callback: @escaping (T) -> Void)
    func getMovie<T: Codable>(idMovie:Int, callback: @escaping (T) -> Void)
}
