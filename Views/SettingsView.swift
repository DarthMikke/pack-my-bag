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
            Section(header: Text("Avansert")) {
                HStack {
                    Button(action: {}) {
                        Text("Nullstill oppføringar")
                    }.foregroundColor(.red)
                }
            }
            Section(
                header: Text("Anerkjenningar")
            ) {
                HStack(spacing: 0) {
                    Text("Icon by ")
                    Link("Freepik", destination: URL(string: "https://www.freepik.com")!)
                    Text(" from ")
                    Link("www.flaticon.com", destination: URL(string: "https://www.flaticon.com/")!)
                }
            }
        }.navigationTitle("Innstillingar")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
