import Foundation
import SwiftUI
import CoreData

public enum AppState: String {
    case main = "main", newItem = "newItem", newContainer = "new container"
}

public class AppModel: ObservableObject {/*
    @Published public var items: [Item]
    @Published public var containers: [Container] */
    @Published public var selection: UUID? = nil
    @Published public var newContainer: Bool = false
    @Published public var newList: Bool = false
    public var draggedItem: Item? = nil
    public var moc: NSManagedObjectContext? = nil
    
    public init() {
        return
    }
    
    public init(moc: NSManagedObjectContext) {
        self.moc = moc
        /*items = []
        containers = [Container(name: "Container 1")]*/
        return
    }
    
    public func drag(item: Item) {
        self.draggedItem = item
    }
    
    public func drop(to newId: UUID) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Container")
        fetchRequest.predicate = NSPredicate(format: "id == %@", newId.uuidString)
        
        let newContainer: NSManagedObject?
        
        do {
            newContainer = try self.moc!.fetch(fetchRequest).first ?? nil
        } catch {
            print("\(#fileID):\(#line): Kunne ikkje utføre sleppet.")
            return
        }
        
        if newContainer == nil {
            print("\(#fileID):\(#line): Kunne ikkje utføre sleppet.")
            return
        }
        
        self.draggedItem!.container = newContainer as! Container
        self.saveContext()
        
        print("\(#fileID):\(#line): \(self.draggedItem!.name ?? "Ukjent ting") vart flytta til \((newContainer as! Container).name ?? "Ukjent kontainer").")
    }
    
    //MARK: Items
    public func addItem(name: String, containerId: String?) {
    /*    if containerId == nil {
            self.items.append(
                Item(name: name, container: nil)
            )
        } else {
            guard let containerIndex = self.containers.firstIndex(
                    where: {$0.name == containerId}
            ) else {
                return
            }
            self.items.append(
                Item(name: name, container: containers[containerIndex])
            )
        } */
    }
    
    //MARK: Containers
    public func addContainer(name: String) { // throws {
        /*if self.containerExists(name: name) {
            // throw
            return
        }*/
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PackingList")
        fetchRequest.predicate = NSPredicate(format: "id == %@", self.selection!.uuidString)
        var result: NSManagedObject
        do {
            result = try self.moc!.fetch(fetchRequest).first!
        } catch {
            print("\(#fileID):\(#line): error executing fetch request: \(error)")
            return
        }
        
        let container = Container(context: self.moc!)
        container.id = UUID()
        container.name = name
        container.packingList = result as! PackingList
        
        self.saveContext()
    }
    
    ///Ny kontainer skal vera synleg.
    public func addContainerToView() {
        self.newContainer = true
    }
    
    public func containerExists(name: String) -> Bool {
        ///Henta frå
        ///https://stackoverflow.com/questions/51190576/checking-if-entity-exist-before-saving-it-to-core-data-swift4/51191399
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Container")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        var results: [NSManagedObject] = []
        
        do {
            results = try self.moc!.fetch(fetchRequest)
        } catch {
            print("error executing fetch request: \(error)")
        }
        
        return results.count > 0
    }
    
    //MARK: Lists
    public func addList(name: String) {
        let list = PackingList(context: self.moc!)
        list.id = UUID()
        list.name = name
        
        self.saveContext()
    }
    
    public func saveContext() {
        if self.moc!.hasChanges {
            try? self.moc!.save()
        }
    }
}
