//
//  Container+CoreDataProperties.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 31/08/2021.
//
//

import Foundation
import CoreData


extension Container {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Container> {
        return NSFetchRequest<Container>(entityName: "Container")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Container {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}

extension Container : Identifiable {

}