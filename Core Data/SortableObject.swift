//
//  SortableObject.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 09/10/2021.
//

import Foundation

public protocol SortableObject {
    var created: Date? { get set }
    var modified: Date? { get set }
    var name: String? { get set }
}

extension PackingList: SortableObject {
    
}

extension Container: SortableObject {
    
}

extension Item: SortableObject {
    
}
