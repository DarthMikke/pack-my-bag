//
//  PackingListView.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 05/09/2021.
//

import SwiftUI

struct PackingListView: View {
    @EnvironmentObject var appModel: AppModel
    var model: PackingList
    
    var body: some View {
        List {
            ForEach(model.containerArray, id: \.id) { container in
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
