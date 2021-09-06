//
//  ItemModel.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 01/09/2021.
//

import Foundation
import SwiftUI

public class ItemViewModel: ObservableObject {
    var model: Item
    @Published var name: String
    @Published var isPacked: Bool
    @Published var isEditing: Bool = false
    
    init(_ item: Item) {
        self.model = item
        self.name = item.name!
        self.isPacked = item.isPacked
    }
    
    init(container: Container?) {
        self.model = Item()
        self.name = ""
        self.isPacked = false
    }
    
    func edit() {
        self.isEditing = true
    }
    
    public func saveChanges() {
        self.model.name = self.name
        self.model.isPacked = self.isPacked
        
        self.saveContext()
        self.isEditing = false
    }
    
    public func remove() {
        self.model.managedObjectContext!.delete(self.model)
        self.saveContext()
    }
    
    public func saveContext() {
        print("Saving changes.")
        
        let context = model.managedObjectContext!
        
        if context.hasChanges {
            try? context.save()
        }
    }
}
