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
        self.name = (item.name == "" ? "" : item.name) ?? ""
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
        
        debugprint("Saving changes to the item...")
        self.saveContext()
        self.isEditing = false
        debugprint("Saved changes to the item.")
    }
    
    public func remove() {
        debugprint("Removing item.")
        self.model.managedObjectContext!.delete(self.model)
        self.saveContext()
    }
    
    public func saveContext() {
        debugprint("Saving changes to the context...", terminator: " ")
        
        let context = model.managedObjectContext!
        
        if context.hasChanges {
            try? context.save()
        }
        debugprint("OK.", noLead: true)
    }
}
