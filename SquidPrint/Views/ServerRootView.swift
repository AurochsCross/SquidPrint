//
//  RootView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-21.
//

import SwiftUI

struct ServerRootView: View {
    @ObservedObject var viewModel: ServerRootViewModel
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            ServerSettingsView()
                .tabItem {
                    
                        Image(systemName: "gear")
                        Text("Settings")
                }
        }
    }
}

struct ServerRootView_Previews: PreviewProvider {
    static var previews: some View {
        UnderConstructionView(viewName: "Root")
    }
}
