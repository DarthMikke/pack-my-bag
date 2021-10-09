//
//  ListSortingPicker.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 07/10/2021.
//

import SwiftUI

struct ListSortingPicker: View {
    @Binding var selection: SortingOrder
    
    var body: some View {
        Menu {
            ForEach(SortingOrder.allCases, id: \.rawValue) { sortingOrder in
                Button(sortingOrder.long, action: {
                    self.selection = sortingOrder
                })
            }
        } label: {
            Label("Sort by", systemImage: "arrow.up.arrow.down")
        }
    }
}

struct ListSortingPicker_Previews: PreviewProvider {
    @State static var selection: SortingOrder = .createdNto
    
    static var previews: some View {
        ListSortingPicker(selection: self.$selection)
    }
}
