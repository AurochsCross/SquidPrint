//
//  InitialServerSettingsView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-21.
//

import SwiftUI

struct CreateServerView: View {
    @ObservedObject var viewModel: CreateServerViewModel
    
    var body: some View {
        NavigationView {
            List {
                InputRow(title: "Server name", placeholder: "Optional", input: $viewModel.name)

                Section(header: Text("Connection")) {
                    InputRow(title: "Address", placeholder: "", input: $viewModel.address)
                        .keyboardType(.URL)
                    InputRow(title: "Port", placeholder: "Optional", input: $viewModel.port)
                        .keyboardType(.numberPad)
                    InputRow(title: "API Key", placeholder: "", input: $viewModel.apiKey)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text("Settings"))
            .navigationBarItems(trailing: Button(action: { self.viewModel.onSave() }) {
                Text("Save")
            })
        }
    }
}

struct CreateServerView_Previews: PreviewProvider {
    static var previews: some View {
        CreateServerView(viewModel: CreateServerViewModel(onSave: .init()))
    }
}
