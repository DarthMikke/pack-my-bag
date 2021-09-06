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
                .buttonStyle(CustomButtonStyle())
            }
            Form {
                Section(header: Text("Ny oppbevaring")) {
                    TextField("Namn", text: self.$newContainerName)
                    Button(action: self.addContainer) {
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
    
    fileprivate func addContainer() {
        self.appModel.addContainer(name: self.newContainerName)
        self.appModel.newContainer = false
    }
}

struct CustomButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        #if os(macOS)
        return configuration.label.buttonStyle(LinkButtonStyle())
        #elseif os(iOS)
        return configuration.label.buttonStyle(DefaultButtonStyle())
        #endif
    }
}
