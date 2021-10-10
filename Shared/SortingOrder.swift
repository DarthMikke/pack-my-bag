//
//  SortingOrder.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 09/10/2021.
//

import Foundation

public enum SortingOrder: String, CaseIterable {
    case createdNto, createdOtn, /*modifiedNto, modifiedOtn,*/ AZ, ZA
    
    var long: String {
        switch self {
        case .createdOtn:
            return "Created, oldest to newest"
        case .createdNto:
            return "Created, newest to oldest"
/*        case .modifiedOtn:
            return "Modified, oldest to newest"
        case .modifiedNto:
            return "Modified, newest to oldest"*/
        case .AZ:
            return "A-Z"
        case .ZA:
            return "Z-A"
        }
    }
}
