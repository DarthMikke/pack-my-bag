//
//  Container.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 31/08/2021.
//

import Foundation

extension Container {
    public var itemArray: [Item] {
        let set = items as? Set<Item> ?? []
        return set.sorted { $0.name! < $1.name! }
    }
}
