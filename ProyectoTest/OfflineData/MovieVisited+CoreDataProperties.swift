//
//  MovieVisited+CoreDataProperties.swift
//  ProyectoTest
//
//  Created by Patricio Tovar on 6/10/22.
//
//

import Foundation
import CoreData


extension MovieVisited {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieVisited> {
        return NSFetchRequest<MovieVisited>(entityName: "MovieVisited")
    }

    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var release_year: String?
    @NSManaged public var vote_average: Double

}

extension MovieVisited : Identifiable {

}
