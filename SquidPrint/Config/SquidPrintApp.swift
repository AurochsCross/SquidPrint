//
//  SquidPrintApp.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-19.
//

import SwiftUI

@main
struct SquidPrintApp: App {
    let appEnvironment = AppEnvironment()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appEnvironment)
        }
    }
}