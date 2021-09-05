// ItemView.swift

import SwiftUI

public struct ItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewmodel: ItemViewModel
    
    public init(item: Item) {
        self.viewmodel = ItemViewModel(item)
    }
    
    public var body: some View {
        HStack {
            Toggle("", isOn: $viewmodel.isPacked)
                .toggleStyle(CustomToggleStyle())
                .accessibility(label: Text("Pakka"))
                .disabled(viewmodel.isEditing)
            if !viewmodel.isEditing {
                if self.viewmodel.isPacked {
                    Text(viewmodel.name).strikethrough()
                        .onTapGesture {
                            self.viewmodel.edit()
                        }
                } else {
                    Text(viewmodel.name)
                        .onTapGesture {
                            self.viewmodel.edit()
                        }
                }
                Spacer()
            } else {
                TextField("Kaffikopp", text: self.$viewmodel.name)
                Spacer()
                Button("Lagre", action: {
                    self.viewmodel.saveChanges()
                })
                Button("Fjern", action: {
                    self.viewmodel.remove()
                }).foregroundColor(.red)
            }
        }
    }
}

/*
extension View {
    func conditional<Content: View>(
        when condition: Bool,
        _ modifier: (Self) -> Content
    ) -> some View {
        if condition {
            return modifier(self)
        } else {
            return self
        }
    }
}
*/
