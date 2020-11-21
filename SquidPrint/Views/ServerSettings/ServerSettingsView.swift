//
//  ServerSettingsView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import SwiftUI
import SquidPrintLogic

struct ServerSettingsView: View {
    @ObservedObject var viewModel: ServerSettingsViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Connection")) {
                    HStack {
                        Text("Api key")
                        Spacer()
                        TextField("Api Key", text: $viewModel.apiKey)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(Text("Settings"))
            .navigationBarItems(trailing: Button(action: { self.viewModel.onSave() }) {
                Text("Save")
            })
            .onAppear { self.viewModel.onAppear() }
        }
    }
}

struct ServerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let serverManager = ServerManager(coreDataStorage: DefaultServiceContainer().coreDataStorage)
        return ServerSettingsView(viewModel: ServerSettingsViewModel(serverManager: serverManager))
    }
}
