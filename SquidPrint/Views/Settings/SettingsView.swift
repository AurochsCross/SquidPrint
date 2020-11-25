//
//  SettingsView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-23.
//

import SwiftUI
import Combine
import SquidPrintLogic

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Server configuration")) {
                    NavigationLink(
                        destination: ServerSettingsView(viewModel: viewModel.serverSettingsViewModel),
                        isActive: $viewModel.showServerSettings,
                        label: {
                            ServerConfigurationQuickView(serverSettings: viewModel.serverConfiguration)
                        })
                }
                
                Section(header: Text("Server Management")) {
                    Button(action: { self.viewModel.switchServer(appEnvironment) }) {
                        Text("Switch server")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: { self.viewModel.deleteServer(appEnvironment) }) {
                        Text("Delete server")
                    }
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text("Settings"))
        }
    }
    
    struct ServerConfigurationQuickView: View {
        let serverSettings: ServerSettings
        
        private var hiddenApiKey: String {
            let revealedSymbols = serverSettings.apiKey.count < 3 ? serverSettings.apiKey.count : 3
            return String(serverSettings.apiKey.prefix(revealedSymbols))
                .appending(String(repeating: "*", count: serverSettings.apiKey.count - revealedSymbols))
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                if let name = serverSettings.name {
                    Text(name)
                        .font(.title)
                        .bold()
                }
                Text(serverSettings.fullAddress)
                Text(hiddenApiKey)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel(serverManager: MockServerManager()))
    }
}

