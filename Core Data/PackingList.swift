//
//  PackingList.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 05/09/2021.
//

import Foundation

extension PackingList {
    public var containerArray: [Container] {
        let set = containers as? Set<Container> ?? []
        return set.sorted { $0.name! < $1.name! }
    }
    
    func updateModifiedDate() {
        self.modified = Date()
        try? self.managedObjectContext!.save()
    }
}
