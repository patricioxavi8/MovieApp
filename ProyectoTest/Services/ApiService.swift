//
//  ApiService.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 3/10/22.
//

import Foundation
import Alamofire

final class APIService : Services{
    
    
    
    func get<T: Codable>(pageNumber:Int, callback: @escaping (T) -> Void) {
        
        let url = Constants.FULL_URL+"&page=\(pageNumber)"
        AF.request(url, method: .get).responseDecodable(of: T.self, queue: .main) { result in
            if let error = result.error {
                print(error.localizedDescription)
                return
            }
            
            if let value = result.value {
                
                callback(value)
            } else {
                print("[Error]: Missing value.")
                
            }
        }
    }
    
    
    
    func getMovie<T: Codable>(idMovie:Int, callback: @escaping (T) -> Void) {
        let url = "\(Constants.MOVIE_SEARCH_BASE_URL)\(idMovie)?api_key=\(Constants.API_KEY)&append_to_response=videos"
        AF.request(url, method: .get).responseDecodable(of: T.self, queue: .main) { result in
            if let error = result.error {
                print(error.localizedDescription)
                return
            }
            if let value = result.value {
                
                callback(value)
            } else {
                print("[Error]: Missing value.")
            }
        }
    }
}




