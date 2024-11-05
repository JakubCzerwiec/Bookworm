//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Mój Maczek on 02/11/2024.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self) // This needs to be added to have a "space" in memory for our books
    }
}
