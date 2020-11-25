//
//  RootView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-21.
//

import SwiftUI
import SquidPrintLogic

struct ServerRootView: View {
    @ObservedObject var viewModel: ServerRootViewModel
    var body: some View {
        TabView {
            DashboardView(viewModel: viewModel.dashboardViewModel)
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
            
            TemperatureView()
                .tabItem {
                    Image(systemName: "thermometer")
                    Text("Temperature")
                }
            
            SettingsView(viewModel: viewModel.settingsViewModel)
                .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                }
        }
    }
}

struct ServerRootView_Previews: PreviewProvider {
    static var previews: some View {
        ServerRootView(viewModel: ServerRootViewModel(serverManager: MockServerManager()))
    }
}
