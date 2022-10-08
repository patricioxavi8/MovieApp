//
//  ViewModelDetailTest.swift
//  ProyectoTestTests
//
//  Created by Patricio Tovar on 7/10/22.
//

@testable import ProyectoTest
import XCTest

class ViewModelDetailTest: XCTestCase {
    
    var viewModelDetail: MovieDetailViewModel!
    var mockService: MockService!
    override func setUp() {
        mockService = MockService()
        viewModelDetail = .init(apiService:  mockService )
    }
    
    func testMoviesMoreDetail(){
        viewModelDetail.getMovie(idMovie: 1) { (movie:Movie)  in
            
        }
        XCTAssertTrue(viewModelDetail._movie.id==1)
        
    }
    
    func testVisitedMovieExists(){
        
        viewModelDetail.getMovie(idMovie: 1) { (movie:Movie)  in}
        XCTAssertTrue(viewModelDetail.checkIfMovieExists())
        
    }
    
}
