//
//  MockPackingList.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 06/10/2021.
//

import Foundation

struct MockPackingList: PackingListProtocol {
    var name: String?
    var containers: Set<MockContainer>?
}

protocol PackingListProtocol {
    associatedtype C: ContainerProtocol
    var name: String? { get set }
    var containers: Set<C>? { get set }
}
