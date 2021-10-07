//
//  SettingsView.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 04/10/2021.
//

import SwiftUI
import Combine

struct SettingsView: View {
    //@EnvironmentObject var appModel: AppModel
    @StateObject var appModel: AppModel
    @State var showingAlert = false
    var cancellable: AnyCancellable?
    
    init(_ appModel: AppModel) {
        self._appModel = StateObject(wrappedValue: appModel)
        #if DEBUG
        cancellable = self.appModel.$selectedLanguage.receive(on: DispatchQueue.main).sink {
            debugprint("Set språk til \($0).")
            UserDefaults.standard.set($0.short, forKey: "language")
        }
        #endif
    }
    
    var body: some View {
        List {
            Section {
                Picker(LocalizedStringKey("Choose language"), selection: self.$appModel.selectedLanguage) {
                    ForEach(AppLanguage.allCases) { language in
                        Text(language.long).tag(language)
                    }
                }
                .onChange(of: self.appModel.selectedLanguage) {debugprint($0)}
                Button(action: { self.appModel.prefilledLists() }) {
                    Text(LocalizedStringKey("Restore predefined lists"))
                }
                .alert(isPresented: $showingAlert) {
                    Alert(
                        title: Text(LocalizedStringKey("Continue?")),
                        message: Text(LocalizedStringKey("This will add some example lists.")),
                        primaryButton: .default(
                            Text(LocalizedStringKey("Continue")),
                            action: {
                                self.appModel.prefilledLists()
                            }
                        ),
                        secondaryButton: .default(Text(LocalizedStringKey("Cancel"))))
                }
                HStack {
                    Button(action: { showingAlert = true }) {
                        Text(LocalizedStringKey("Remove all items"))
                    }.foregroundColor(.red)
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text(LocalizedStringKey("Continue?")),
                                message: Text(LocalizedStringKey("Removing all lists alert")),
                                primaryButton: .destructive(
                                    Text(LocalizedStringKey("Continue")),
                                    action: {
                                        self.appModel.purgeAllItems()
                                        self.appModel.prefilledLists()
                                    }
                                ),
                                secondaryButton: .default(Text(LocalizedStringKey("Cancel")))
                            )
                        }
                }
            }
            Section(
                header: Text("Credits")
            ) {
                HStack(spacing: 0) {
                    Text("Icon by ")
                    Link("Freepik", destination: URL(string: "https://www.freepik.com")!)
                    Text("iconFrom")
                    Link("www.flaticon.com", destination: URL(string: "https://www.flaticon.com/")!)
                }
            }
        }.navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(AppModel())
    }
}
