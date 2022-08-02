//
//  FishingDiaryApp.swift
//  FishingDiary
//
//  Created by Joni Lassila on 2.8.2022.
//

import SwiftUI

@main
struct FishingDiaryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
