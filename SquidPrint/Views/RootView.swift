//
//  RootView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-21.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    var body: some View {
        TabView {
            UnderConstructionView(viewName: "App")
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ServerSettingsView(viewModel: self.viewModel.serverSettingsViewModel)
                .tabItem {
                    
                        Image(systemName: "gear")
                        Text("Settings")
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel())
    }
}
