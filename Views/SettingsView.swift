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
                    Text("Gjenopprett forhandsdefinerte lister")
                }
                HStack {
                    Button(action: {}) {
                        Text("Remove all items")
                    }.foregroundColor(.red)
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
