//
//  Pack_my_BagApp.swift
//  Shared
//
//  Created by Michal Jan Warecki on 31/08/2021.
//

import SwiftUI

@main
struct Pack_my_BagApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
