//
//  NewListView.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 28/09/2021.
//

import SwiftUI

public struct NewListView: View {
    @EnvironmentObject var appModel: AppModel
    @Environment(\.managedObjectContext) private var viewContext
    @State public var newList: String = ""
    @State private var cannotSave: Bool = false
    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        self.appModel.newList = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .scaleEffect(1.25)
                        .padding(10)
                }
                .buttonStyle(CustomLinkButtonStyle())
            }
            Text(NSLocalizedString("Give name to list", comment: "")).font(.headline)
            Form {
                Section(header: Text(NSLocalizedString("New list", comment: ""))) {
                    TextField(NSLocalizedString("List name", comment: ""), text: self.$newList)
                    Button(action: self.addList) {
                        Text("Save")
                    }
                    .buttonStyle(CustomLinkButtonStyle())
                    //.disabled(self.cannotSave)
                }
            }
        }.background(Color(red: 242.0/255.0, green: 242.0/255.0, blue: 247.0/255.0))
        /*.onChange(of: self.newContainerName, perform: { oldValue in
            print("Checking for existing container named \(self.newContainerName)...")
            let cannotSave: Bool = {
                if self.newContainerName == "" {
                    return true
                }
                return self.appModel.containerExists(name: self.newContainerName)
            }()
            print(cannotSave ? "Kan ikkje lagre." : "Kan lagre.")
            self.cannotSave = cannotSave
        })*/
    }
    
    fileprivate func addList() {
        self.appModel.addList(name: self.newList)
        self.appModel.newList = false
    }
}
