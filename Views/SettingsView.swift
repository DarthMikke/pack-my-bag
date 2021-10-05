//
//  SettingsView.swift
//  Pack my Bag
//
//  Created by Michal Jan Warecki on 04/10/2021.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section(header: Text("Advanced")) {
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
        SettingsView()
    }
}
