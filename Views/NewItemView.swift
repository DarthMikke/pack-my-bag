
// NewItemView

import SwiftUI

public struct NewItemView: View {
    @EnvironmentObject var appModel: AppModel
    var isPresented: Binding<Bool>
    
    @State var isPacked = false
    @State var name: String
    var container: Container?
    
    public init(isPresented: Binding<Bool>, container: Container? = nil) {
        self.isPresented = isPresented
        self._name = State(initialValue: "")
        self.container = container
    }
    
    public var body: some View {
        HStack {
            Toggle("", isOn: $isPacked)
                .toggleStyle(CustomToggleStyle())
                .accessibility(label: Text("Pakka"))
                .disabled(true)
            TextField("Kaffikopp", text: $name)
            Spacer()
            Button("Lagre", action: {})
                .onTapGesture {
                    self.save()
                    self.empty()
                }
            Button("Avbryt", action: {})
                .foregroundColor(.red)
                .onTapGesture {
                    self.empty()
                }
        }
    }
    
    func save() {
        let item = Item(context: appModel.moc!)
        item.name = self.name
        item.id = UUID()
        item.container = self.container
        
        self.appModel.saveContext()
    }
    
    func empty() {
        self.name = ""
        self.isPresented.wrappedValue = false
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
    //    #if os(iOS)
        return HStack {
            Image(systemName: configuration.isOn
                    ? "circle.fill"
                    : "circle")
            configuration.label
        }.onTapGesture {
            configuration.isOn.toggle()
        }
    /*    #elseif os(macOS)
        return configuration.label.toggleStyle(CheckboxToggleStyle())
        #endif */
    }
}
