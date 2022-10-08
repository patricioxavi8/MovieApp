//
//  ProyectoTestTests.swift
//  ProyectoTestTests
//
//  Created by Patricio Tovar on 7/10/22.
//
@testable import ProyectoTest
import XCTest

class ProyectoTestTests: XCTestCase {
    
    var viewModelHome: HomeViewModel!
    var mockService: MockService!
    override func setUp() {
        mockService = MockService()
        viewModelHome = .init(apiService:  mockService )
    }
    

    
    func testMoviesList(){
        viewModelHome.get(pageNumber: 1) { (lista:MoviesResponse)  in
            
        }
        XCTAssertTrue(viewModelHome._movies.count==20)
    }
    
    func testGetMovieId(){
        viewModelHome.get(pageNumber: 1) { (lista:MoviesResponse)  in
            
        }
        
        let movie = viewModelHome._movies[2] as! Movie
        XCTAssertTrue(movie.id==3)
    }
    
  

}
