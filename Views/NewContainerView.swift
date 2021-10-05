// NewContainerView.swift

import SwiftUI

public struct NewContainerView: View {
    @EnvironmentObject var appModel: AppModel
    @Environment(\.managedObjectContext) private var viewContext
    @State public var newContainerName: String = ""
    @State private var cannotSave: Bool = false
    
    public init() {
        return
    }
    
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
                .buttonStyle(CustomLinkButtonStyle())
            }
            Text(LocalizedStringKey("Give name to new storage")).font(.headline)
            Form {
                Section(header: Text("New storage")) {
                    TextField(LocalizedStringKey("Name"), text: self.$newContainerName)
                    Button(action: self.addContainer) {
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
    
    fileprivate func addContainer() {
        self.appModel.addContainer(name: self.newContainerName)
        self.appModel.newContainer = false
    }
}
