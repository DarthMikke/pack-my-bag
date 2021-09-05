//
//  PackingList+CoreDataProperties.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 05/09/2021.
//
//

import Foundation
import CoreData


extension PackingList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PackingList> {
        return NSFetchRequest<PackingList>(entityName: "PackingList")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var created: Date?
    @NSManaged public var containers: NSSet?

}

// MARK: Generated accessors for containers
extension PackingList {

    @objc(addContainersObject:)
    @NSManaged public func addToContainers(_ value: Container)

    @objc(removeContainersObject:)
    @NSManaged public func removeFromContainers(_ value: Container)

    @objc(addContainers:)
    @NSManaged public func addToContainers(_ values: NSSet)

    @objc(removeContainers:)
    @NSManaged public func removeFromContainers(_ values: NSSet)

}

extension PackingList : Identifiable {

}
