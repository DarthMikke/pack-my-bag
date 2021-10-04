//
//  ContentView.swift
//  Shared
//
//  Created by Michal Jan Warecki on 31/08/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.created, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @FetchRequest(sortDescriptors: [])
    private var containers: FetchedResults<Container>
    @FetchRequest(sortDescriptors: [])
    private var lists: FetchedResults<PackingList>
    
    @ObservedObject var appModel: AppModel = AppModel()
    @State var selection: String? = nil
    
    init() {
        return
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(lists, id: \.id) { list in
                    NavigationLink(
                        destination: PackingListView(model: list)
                            .navigationTitle(list.name ?? "Ukjent liste")
                            .toolbar {
                                #if os(iOS)
                                ToolbarItemGroup(placement: .navigationBarTrailing) {
                                    Spacer()
                                    /*NavigationLink(
                                        destination: NewItemView(),
                                        tag: AppState.newItem.rawValue,
                                        selection: self.$appModel.selection) {
                                        Text("Add item")
                                    }*/
                                    Button(action: { self.appModel.newContainer = true }) {
                                        Text("Add container")
                                    }
                                }
                                #elseif os(macOS)
                                Spacer()
                                Button(action: {
                                    self.appModel.addContainerToView()
                                }) {
                                    Image(systemName: "bag.badge.plus")
                                }
                                #endif
                            }
                            .sheet(
                                isPresented: $appModel.newContainer,
                                onDismiss: {
                                    print("\(#fileID):\(#line): Dismissed")
                                    self.appModel.newContainer = false
                                }
                            ) { NewContainerView() },
                        tag: list.id!,
                        selection: self.$appModel.selection
                    ) {
                        Text(list.name ?? "Ukjent liste")
                    }
                }
                if lists.map({$0}).isEmpty {
                    Text("Her var det tomt. Legg til ei liste for å begynne.")
                }
            }
            .toolbar {
                #if os(iOS)
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Spacer()
                    /*NavigationLink(
                        destination: NewItemView(),
                        tag: AppState.newItem.rawValue,
                        selection: self.$appModel.selection) {
                        Text("Add item")
                    }*/
                    Button(action: {
                        self.appModel.newList = true
                    }) {
                        Text("Add list")
                    }
                }
                #elseif os(macOS)
                Spacer()
                Button(action: { //TODO: Ny liste
                    //self.appModel.addContainerToView()
                }) {
                    Image(systemName: "text.badge.plus")
                }
                #endif
            }
            .navigationTitle("Pack my bag")
            .sheet(isPresented: $appModel.newList) {
                NewListView()
            }
            
            Label("Vel ei liste i panelet til venstre.", systemImage: "arrow.left")
           /* .iOS {
                #if os(iOS)
                $0.navigationBarTitle("Pakkehjelp")
                #else
                $0
                #endif
            }
            .iOS {
                #if os(iOS)
                $0.navigationBarTitleDisplayMode(.large)
                #else
                $0
                #endif
            }*/
        }
        .onAppear {
            self.appModel.moc = viewContext
            self.migrate()
        }
        .environmentObject(self.appModel)
    }
    
    /*func handleDrop(itemId: UUID) {
        print("\(#fileID):\(#line): Har fått \(itemId.uuidString).")
    }*/
    
    ///Migrate to new version of core data storage.
    private func migrate() {
        //MARK: - Missing attributes in item, container
        var missing = [0, 0, 0] // item timestamps, item ids, container ids.
        for item in items {
            if item.created == nil {
                item.created = Date()
                missing[0] += 1
            }
            if item.id == nil {
                item.id = UUID()
                missing[1] += 1
            }
        }
        for container in containers {
            if container.id == nil {
                container.id = UUID()
                missing[2] += 1
            }
        }
        print("\(#fileID):\(#line): \(missing[0]) ting mangla opprettingsdato.")
        print("\(#fileID):\(#line): \(missing[1]) ting mangla ID.")
        print("\(#fileID):\(#line): \(missing[2]) kontainerar mangla ID.")
        
        //MARK: - Implementing Packing Lists
        if lists.map({$0}).isEmpty {
            let firstList = PackingList(context: viewContext)
            firstList.name = "My first packing list"
            firstList.id = UUID()
            firstList.created = Date()
        } else {
            for list in lists {
                if list.name == nil {
                    list.name = "Ukjent liste"
                }
                if list.id == nil {
                    list.id = UUID()
                }
                if list.created == nil {
                    list.created = Date()
                }
            }
        }
        let found = containers.filter({$0.packingList == nil}).count
        print("\(#fileID):\(#line): Fann \(found) kontainerar utan liste.")
        if found > 0 {
            let newList = PackingList(context: viewContext)
            newList.id = UUID()
            newList.name = "Funne element"
            newList.created = Date()
            var added = 0
            for container in containers.filter({$0.packingList == nil}) {
                container.packingList = newList
                added += 1
            }
            print("\(#fileID):\(#line): La til \(added) element til ny liste.")
        }
        
        try? viewContext.save()
    }

    private func addItem() {
        withAnimation {
            print("\(#fileID):\(#line): Adding new content")
            let newItem = Item(context: viewContext)
            newItem.name = "Item"
            newItem.id = UUID()
            newItem.container = nil

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension View {
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}
