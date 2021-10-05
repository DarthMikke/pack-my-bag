//
//  MainView.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 05/10/2021.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var appModel: AppModel
    
    @FetchRequest(sortDescriptors: [])
    private var lists: FetchedResults<PackingList>
    
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
                    NavigationLink(destination: SettingsView(self.appModel)) {
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
                        Text(LocalizedStringKey("addList"))
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
            .navigationTitle(LocalizedStringKey("appTitle"))
            .sheet(isPresented: $appModel.newList) {
                NewListView()
            }
            
            Label(LocalizedStringKey("chooseList"), systemImage: "arrow.left")
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
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
