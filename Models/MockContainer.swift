//
//  MockContainer.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 06/10/2021.
//

import Foundation

struct MockContainer: ContainerProtocol {
    var name: String?
    var items: Set<MockItem>?
}

protocol ContainerProtocol: Hashable {
    associatedtype I: ItemProtocol
    var name: String? { get set }
    var items: Set<I>? { get set }
}
