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
    let appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            AppView(viewModel: appViewModel)
                .environmentObject(appEnvironment)
        }
    }
}
