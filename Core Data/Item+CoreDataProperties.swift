//
//  Item+CoreDataProperties.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 01/09/2021.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isPacked: Bool
    @NSManaged public var name: String?
    @NSManaged public var created: Date?
    @NSManaged public var modified: Date?
    @NSManaged public var container: Container?

}

extension Item : Identifiable {

}
