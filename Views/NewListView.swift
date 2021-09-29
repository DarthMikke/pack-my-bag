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
                        self.appModel.newContainer = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .scaleEffect(1.25)
                        .padding(10)
                }
                .buttonStyle(CustomButtonStyle())
            }
            Form {
                Section(header: Text("Ny liste")) {
                    TextField("Namn", text: self.$newList)
                    Button(action: self.addList) {
                        Text("Lagre")
                    }
                    .buttonStyle(CustomButtonStyle())
                    //.disabled(self.cannotSave)
                }
            }
            .padding(20)
        }
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
