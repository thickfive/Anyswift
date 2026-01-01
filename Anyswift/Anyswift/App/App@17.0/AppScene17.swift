//
//  AppScene17.swift
//  AnySwift
//
//  Created by vvii on 2026/1/1.
//

#if AVAILABLE_IOS_17
import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct AppScene17: Scene {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView17()
        }
        .modelContainer(sharedModelContainer)
    }
}
#endif


