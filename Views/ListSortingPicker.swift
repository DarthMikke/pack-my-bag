//
//  ListSortingPicker.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 07/10/2021.
//

import SwiftUI

struct ListSortingPicker: View {
    @Binding var selection: SortingOrder
    let completionHandler: (SortingOrder) -> Void = {_ in }
    
    var body: some View {
        Menu {
            ForEach(SortingOrder.allCases, id: \.rawValue) { sortingOrder in
                Button(
                    action: {
                        self.selection = sortingOrder
                        self.completionHandler(sortingOrder)
                    }
                ) {
                    Text(LocalizedStringKey(sortingOrder.long))
                }
            }
        } label: {
            Label(LocalizedStringKey("Sort by"), systemImage: "arrow.up.arrow.down")
        }
    }
}

struct ListSortingPicker_Previews: PreviewProvider {
    @State static var selection: SortingOrder = .createdNto
    
    static var previews: some View {
        ListSortingPicker(selection: self.$selection)
    }
}
