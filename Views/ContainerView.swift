//
//  ContainerView.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 01/09/2021.
//

import SwiftUI

struct ContainerView: View {
    @EnvironmentObject var appModel: AppModel
    @ObservedObject var viewmodel: ContainerViewModel
    
    
    init(_ container: Container) {
        self.viewmodel = ContainerViewModel(container)
    }
    
    init(_ name: String, items: [Item]) {
        self.viewmodel = ContainerViewModel(name, items: items)
    }
    
    var body: some View {
        Section(
            header:
                HStack {
                    Button(action: {
                        withAnimation {
                            self.viewmodel.collapsed.toggle()
                        }
                    }) {
                        Image(systemName:
                                viewmodel.collapsed
                                    ? "arrowtriangle.right.fill"
                                    : "arrowtriangle.down.fill"
                        )
                    }
                    Text(viewmodel.name)
                    Spacer()
                    if self.viewmodel.model != nil {
                        Button(action: {
                            // Rediger
                            self.viewmodel.isEditing = true
                        }) { Image(systemName: "square.and.pencil") }
                    }
                    Button(action: {
                        // Ny ting
                        self.viewmodel.newItem = true
                    }) { Image(systemName: "plus") }
                }.buttonStyle(CustomButtonStyle())
            ) {
                if !viewmodel.collapsed {
                    if viewmodel.newItem {
                        NewItemView(isPresented: $viewmodel.newItem, container: self.viewmodel.model)
                    }
                    ForEach(viewmodel.items, id: \.id) { item in
                        ItemView(item: item)
                            .onDrag { self.appModel.drag(item: item)
                                /* print("\(#fileID):\(#line): Dreg \(item.id!.uuidString) ") */
                                return NSItemProvider(
                                    item: .some(item.id!.uuidString as NSSecureCoding),
                                    typeIdentifier: "public.plain-text")
                            }
                            // .onDeleteCommand(perform: { print("Fjernar \(item.id?.uuidString ?? "ukjent ting").") } )
                    }
                    .onDelete(perform: { print("\(#fileID):\(#line): \($0)") })
                }
            }
            .sheet(isPresented: $viewmodel.isEditing) {
            //TODO: Kan dette integrerast i NewContainerView?
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            self.viewmodel.dismissModal()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .scaleEffect(1.25)
                            .padding(10)
                    }
                    .buttonStyle(CustomButtonStyle())
                }
                Form {
                    Section(header: Text("Ny oppbevaring")) {
                        TextField("Namn", text: self.$viewmodel.name)
                        HStack {
                            Button(action: self.viewmodel.saveChanges) {
                                Text("Lagre")
                                    .foregroundColor(
                                        self.viewmodel.name == ""
                                            ? .black
                                            : .blue
                                    )
                            }
                            .disabled(self.viewmodel.name == "")
                            Spacer()
                            Button(action: self.viewmodel.remove) {
                                Label("Fjern", systemImage: "bin.xmark")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .buttonStyle(CustomButtonStyle())
                }
                .padding(20)
            }
        }
    }
}

struct ItemDropDelegate: DropDelegate {
    // let completionHandler: (UUID) -> Void
    let appModel: AppModel
    let target: Container
    
    func performDrop(info: DropInfo) -> Bool {
        /*guard info.hasItemsConforming(to: ["public.string"]) else {
            print("\(#fileID):\(#line): ")
            return false
        }*/
        print("Mottar eit dropp…")

        let items = info.itemProviders(for: ["public.plain-text"])
        print("\(#fileID):\(#line): Mottok eit dropp med \(items.count) ting av typen \("public.plain-text").")
        
        for _ in items {
            self.appModel.drop(to: self.target.id!)
            /*if !item.canLoadObject(ofClass: NSString.self) {
                print("\(#fileID):\(#line): Kan ikkje dekode objektet.")
                return false
            }
            item.loadObject(ofClass: NSString.self, completionHandler: { uuidString, error in
                /*if error != nil {
                    print("\(#fileID):\(#line): Error: \(error)")
                    return
                }*/
                print("\(#fileID):\(#line): Flyttar \(uuidString)")
                DispatchQueue.main.async {
                    // self.completionHandler(UUID(uuidString: uuidString as! String)!)
                }
            })*/
        }

        return true
    }
}

/*
struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
*/
