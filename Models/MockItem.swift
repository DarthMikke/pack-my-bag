//
//  MockItem.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 06/10/2021.
//

import Foundation

struct MockItem: ItemProtocol {
    var name: String?
}

protocol ItemProtocol: Hashable {
    var name: String? { get set }
}
