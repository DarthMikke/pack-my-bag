//
//  PackingListView.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 05/09/2021.
//

import SwiftUI

struct PackingListView: View {
    @EnvironmentObject var appModel: AppModel
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var model: PackingList
    @FetchRequest(sortDescriptors: [])
    private var containers: FetchedResults<Container>
    
    /*private var containers: FetchedResults<Container>
    
    init(model: PackingList) {
        self.model = model
        self.containers = model.managedObjectContext!.fetch(
            NSFetchRequest<Container>(
                entityName: "Container",
                sortDescriptors: [],
                predicate: NSPredicate(format: "ANY PackingList.name == %@", model.name as! CVarArg)
            )
        )
    }*/
    
    var body: some View {
        List {
            ForEach(containers.filter({$0.packingList?.id == model.id}), id: \.id) { container in
                ContainerView(container)
                    .onDrop(of: ["public.plain-text"], delegate: ItemDropDelegate(appModel: self.appModel, target: container))
            }
            /*if self.items.filter({
                $0.container == nil
            }).count > 0 {
                ContainerView(
                    "Manglar beholdar",
                    items: self.items.filter({$0.container == nil})
                )
            }*/
        }
    }
}

/*struct PackingListView_Previews: PreviewProvider {
    static var previews: some View {
        PackingListView()
    }
}*/
