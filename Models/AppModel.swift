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
    @Published public var selectedLanguage: AppLanguage = AppLanguage(rawValue: UserDefaults.standard.string(forKey: "language") ?? "system") ?? AppLanguage.system
    var visibleLanguageCode: String {
        get {
        	return selectedLanguage == .system ? Locale.current.languageCode! : selectedLanguage.short
        }
    }
    public var draggedItem: Item? = nil
    public var moc: NSManagedObjectContext? = nil
    
    public init() {
        self.firstRun()
    }
    
    public init(moc: NSManagedObjectContext) {
        self.moc = moc
        /*items = []
        containers = [Container(name: "Container 1")]*/
        return
    }
    
    public func firstRun() {
        if UserDefaults.standard.bool(forKey: "hasBeenRun") {
            debugprint("Appen har vorte køyrt før.")
            return
        }
        
        debugprint("Første køyring. Set opp appen...")
        UserDefaults.standard.set("system", forKey: "language")
        UserDefaults.standard.set(true, forKey: "hasBeenRun")
        debugprint("Språkval set.")
        debugprint("Fyller ut forhandsdefinerte lister...")
        self.prefilledLists()
    }
    
    public func prefilledLists() {
        let lists: Dictionary<String, Array<MockPackingList>> = [
            "en": [
                MockPackingList(
                    name: "Moving",
                    containers: [
                        MockContainer(
                            name: "Kitchen",
                            items: [
                                MockItem(name: "KitchenAid"),
                                MockItem(name: "Plates"),
                                MockItem(name: "Pans"),
                                MockItem(name: "Silverware from Grandma"),
                            ]
                        ),
                        MockContainer(
                            name: "Bathroom",
                            items: [
                                MockItem(name: "Toothbrush"),
                                MockItem(name: "Tooth paste"),
                                MockItem(name: "Towel"),
                                MockItem(name: "Soap dish"),
                                MockItem(name: "Detergents"),
                            ]
                        ),
                        MockContainer(
                            name: "Living room",
                            items: [
                                MockItem(name: "Vase"),
                                MockItem(name: "Coasters"),
                                MockItem(name: "Table cloths"),
                            ]
                        ),
                        MockContainer(
                            name: "Bedroom",
                            items: [
                                MockItem(name: "Duvet"),
                                MockItem(name: "Pillows"),
                                MockItem(name: "Linens"),
                                MockItem(name: "Mattress protector"),
                            ]
                        )
                    ]
                ),
                MockPackingList(
                    name: "Cabin trip",
                    containers: [
                        MockContainer(
                            name: "Big bag",
                            items: [
                                MockItem(name: "Kvikklunsj!"),
                                MockItem(name: "Skiing clothes"),
                                MockItem(name: "Woolen sweather"),
                                MockItem(name: "Underwear"),
                            ]
                        ),
                        MockContainer(
                            name: "Ski cover",
                            items: [
                                MockItem(name: "Ski"),
                                MockItem(name: "Sticks"),
                                MockItem(name: "Shoes"),
                                MockItem(name: "Ski wax"),
                            ]
                        ),
                        MockContainer(
                            name: "Food",
                            items: [
                                MockItem(name: "Mince meat"),
                                MockItem(name: "Spaghetti"),
                                MockItem(name: "Hunter's stew"),
                                MockItem(name: "Tacos"),
                                MockItem(name: "Greens and veggies"),
                                MockItem(name: "Corn"),
                                MockItem(name: "Drink"),
                            ]
                        ),
                    ]
                )
            ],
            "nn": [
                MockPackingList(
                    name: "Flytting",
                    containers: [
                        MockContainer(
                            name: "Kjøken",
                            items: [
                                MockItem(name: "KitchenAid"),
                                MockItem(name: "Fat og tallerkar"),
                                MockItem(name: "Steikepanner"),
                                MockItem(name: "Sølvbestikk frå mormor"),
                            ]
                        ),
                        MockContainer(
                            name: "Bad",
                            items: [
                                MockItem(name: "Tannkost"),
                                MockItem(name: "Tannkrem"),
                                MockItem(name: "Tanntråd"),
                                MockItem(name: "Handdukar"),
                                MockItem(name: "Såpeskål"),
                                MockItem(name: "Vaskemiddel"),
                            ]
                        ),
                        MockContainer(
                            name: "Stove",
                            items: [
                                MockItem(name: "Vase"),
                                MockItem(name: "Bordbrikkar"),
                                MockItem(name: "Dukar"),
                            ]
                        ),
                        MockContainer(
                            name: "Soverom",
                            items: [
                                MockItem(name: "Dyner"),
                                MockItem(name: "Putar"),
                                MockItem(name: "Sengetøy"),
                                MockItem(name: "Madrassbeskyttar"),
                            ]
                        )
                    ]
                ),
                MockPackingList(
                    name: "Hyttetur",
                    containers: [
                        MockContainer(
                            name: "Stor sekk",
                            items: [
                                MockItem(name: "Ullundertøy"),
                                MockItem(name: "Ullgenser"),
                                MockItem(name: "Kvikklunsj!"),
                                MockItem(name: "Skiklede"),
                            ]
                        ),
                        MockContainer(
                            name: "Skipose",
                            items: [
                                MockItem(name: "Ski"),
                                MockItem(name: "Stavar"),
                                MockItem(name: "Sko"),
                                MockItem(name: "Smøring"),
                            ]
                        ),
                        MockContainer(
                            name: "Mat",
                            items: [
                                MockItem(name: "Kjøtdeig"),
                                MockItem(name: "Spaghetti"),
                                MockItem(name: "Jegargryte (pose)"),
                                MockItem(name: "Tacokrydder"),
                                MockItem(name: "Grønsaker"),
                                MockItem(name: "Maisboksar"),
                                MockItem(name: "Drikke"),
                            ]
                        ),
                    ]
                )
            ]
        ]
        
        lists[lists.keys.contains(self.visibleLanguageCode) ? self.visibleLanguageCode : "en"]!
            .forEach { packingList in
            let listId = UUID()
            self.addList(name: packingList.name!, id: listId)
            packingList.containers?.forEach { container in
                let containerId = UUID()
                self.addContainer(name: container.name!, listId: listId.uuidString, id: containerId)
                container.items?.forEach { item in
                    self.addItem(name: item.name!, containerId: containerId.uuidString)
                }
            }
        }
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
    public func addItem(name: String, containerId: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Container")
        fetchRequest.predicate = NSPredicate(format: "id == %@", containerId)
        var result: NSManagedObject
        do {
            result = try self.moc!.fetch(fetchRequest).first!
        } catch {
            print("\(#fileID):\(#line): error executing fetch request: \(error)")
            return
        }
        
        let item = Item(context: self.moc!)
        item.id = UUID()
        item.name = name
        item.container = result as! Container
        
        self.saveContext()
    }
    
    //MARK: Containers
    
    /// Add a new container to the Core Data store.
    /// - Parameters:
    ///   - name: container name
    ///   - listId: UUID string of a list that the container should belong to. If nil, the currently selected list will be chosen.
    public func addContainer(name: String, listId: String? = nil, id: UUID = UUID()) { // throws {
        /*if self.containerExists(name: name) {
            // throw
            return
        }*/
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PackingList")
        fetchRequest.predicate = NSPredicate(format: "id == %@", listId ?? self.selection!.uuidString)
        var result: NSManagedObject
        do {
            result = try self.moc!.fetch(fetchRequest).first!
        } catch {
            print("\(#fileID):\(#line): error executing fetch request: \(error)")
            return
        }
        
        let container = Container(context: self.moc!)
        container.id = id
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
    public func addList(name: String, id: UUID = UUID()) {
        let list = PackingList(context: self.moc!)
        list.id = id
        list.name = name
        
        self.saveContext()
    }
    
    public func saveContext() {
        if self.moc!.hasChanges {
            try? self.moc!.save()
        }
    }
}
