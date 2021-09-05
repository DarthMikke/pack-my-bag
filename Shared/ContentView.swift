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
    @FetchRequest(sortDescriptors: []) private var containers: FetchedResults<Container>
    
    @ObservedObject var appModel: AppModel = AppModel()
    @State var selection: String? = nil
    
    init() {
        return
    }
    
    var body: some View {
        NavigationView {
            #if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                List {
                    Text("Vel pakkeliste")
                    Text("Ny pakkeliste")
                }
            } else {
                Text("Meny")
            }
            #elseif os(macOS)
                List {
                    Text("Vel pakkeliste")
                    Text("Ny pakkeliste")
                }
            #endif
            List {
                ForEach(containers, id: \.id) { container in
                    ContainerView(container)
                        .onDrop(of: ["public.plain-text"], delegate: ItemDropDelegate(appModel: self.appModel, target: container))
                }
                if self.items.filter({
                    $0.container == nil
                }).count > 0 {
                    ContainerView(
                        "Manglar beholdar",
                        items: self.items.filter({$0.container == nil})
                    )
                }
            }.toolbar {
                #if os(iOS)
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Spacer()
                    /*NavigationLink(
                        destination: NewItemView(),
                        tag: AppState.newItem.rawValue,
                        selection: self.$appModel.selection) {
                        Text("Add item")
                    }*/
                    NavigationLink(
                        destination: NewContainerView(),
                        tag: AppState.newContainer.rawValue,
                        selection: self.$appModel.selection) {
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
                }) { NewContainerView() }
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
        
        try? viewContext.save()
    }

    private func addItem() {
        withAnimation {
            print("Adding new content")
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
