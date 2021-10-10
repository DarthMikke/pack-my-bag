//
//  ContainerViewModel.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 01/09/2021.
//

import Foundation
import SwiftUI

class ContainerViewModel: ObservableObject {
    @Published var collapsed: Bool
    @Published var isEditing = false
    @Published var newItem = false
    let model: Container?
    let id: UUID
    @Published var name: String
    var items: [Item]
    
    init(_ container: Container, isCollapsed: Bool) {
        self._collapsed = Published(initialValue: isCollapsed)
        self.id = container.id!
        self.model = container
        self.name = container.name!
        self.items = container.itemArray
    }
    
    init(_ name: String, items: [Item], isCollapsed: Bool) {
        self._collapsed = Published(initialValue: isCollapsed)
        self.id = UUID()
        self.model = nil
        self.name = name
        self.items = items
    }
    
    func dismissModal() {
        if self.name != model!.name! {
            self.name = model!.name!
        }
        self.isEditing = false
    }
    
    func saveChanges() {
        if self.model == nil {
            self.isEditing = false
            return
        }
        
        self.model!.name = name
        self.model!.modified = Date()
        
        if self.model!.packingList != nil {
            self.model!.packingList!.modified = Date()
        }
        self.saveContext()
        
        self.isEditing = false
    }
    
    func saveContext() {
        print("\(#fileID):\(#line): Saving changes...", terminator: " ")
        
        if self.model == nil {
            print("Error:\n")
            print("\(#fileID):\(#line): Not saving anything – no model.")
            return
        }
        
        let moc = self.model!.managedObjectContext!
        if !moc.hasChanges {
            return
        }
        
        do {
            try moc.save()
        } catch {
            print("Error.")
            print("\(#fileID):\(#line): Couldn't save changes to the context: \(error)")
        }
        print("OK.")
    }
    
    func remove() {
        self.isEditing = false
        if self.model == nil {
            return
        }
        self.model!.managedObjectContext!.delete(self.model!)
        self.saveContext()
    }
}
