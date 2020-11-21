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
                SettingsViewRow(title: "Server name", placeholder: "Name", input: $viewModel.name)
                
                Section(header: Text("Connection")) {
                    SettingsViewRow(title: "Address", placeholder: "Address", input: $viewModel.address)
                        .keyboardType(.URL)
                    SettingsViewRow(title: "Port", placeholder: "Port", input: $viewModel.port)
                        .keyboardType(.numberPad)
                    SettingsViewRow(title: "API Key", placeholder: "API Key", input: $viewModel.apiKey)
                }
                
                Section(header: Text("Other options")) {
                    Button(action: viewModel.onDeleteServer) {
                        Text("Delete Server")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .listRowBackground(Color.red.opacity(0.2))
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
    
    private struct SettingsViewRow: View {
        var title: String
        var placeholder: String
        
        @Binding var input: String
        
        var body: some View {
            HStack {
                Text(title)
                Spacer()
                TextField(placeholder, text: $input)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct ServerSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let serverManager = ServerManager(coreDataStorage: DefaultServiceContainer().coreDataStorage)
        return ServerSettingsView(viewModel: ServerSettingsViewModel(serverManager: serverManager))
    }
}
