//
//  functions.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 02/10/2021.
//

import Foundation

func debugprint(_ items: Any..., separator: String = " ", terminator: String = "\n", fileId: String = #fileID, line: Int = #line, noLead: Bool = false) {
    #if DEBUG
    if !noLead {
        print("\(fileId):\(line):", terminator: separator)
    }
    for item in items {
        print(item, terminator: separator)
    }
    print("", terminator: terminator)
    #endif
}
