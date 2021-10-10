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
                .accessibility(label: Text("Packed"))
                .disabled(viewmodel.isEditing)
                .onChange(of: viewmodel.isPacked) {_ in withAnimation { self.viewmodel.saveChanges() }}
            if !viewmodel.isEditing {
                HStack {
                    if self.viewmodel.isPacked {
                        if self.viewmodel.name == "" {
                            Text("Missing name").foregroundColor(.gray).italic().strikethrough()
                        } else {
                            Text(viewmodel.name).strikethrough()
                        }
                    } else {
                        if self.viewmodel.name == "" {
                            Text("Missing name").foregroundColor(.gray).italic()
                        } else {
                            Text(viewmodel.name)
                        }
                    }
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    self.viewmodel.edit()
                }
            } else {
                TextField("Coffe mug", text: self.$viewmodel.name)
                Spacer()
                Button("Save", action: {})
                    .onTapGesture {
                        debugprint("Save button pressed.")
                        self.viewmodel.saveChanges()
                    }
                Button("Remove", action: {})
                    .onTapGesture {
                        debugprint("Remove button pressed.")
                        self.viewmodel.remove()
                    }
                    .foregroundColor(.red)
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
