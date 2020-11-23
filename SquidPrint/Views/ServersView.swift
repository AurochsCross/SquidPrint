//
//  ServersView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import SwiftUI
import SquidPrintLogic

struct ServersView: View {
    @ObservedObject var viewModel: ServersViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.servers, id: \.id) { server in
                    Button(action: { self.viewModel.select(server: server) }) {
                        Text("\(server.name)")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
            }
            .navigationTitle(Text("Servers"))
            .navigationBarItems(
                trailing: Button(
                    action: { self.viewModel.createServer() }) {
                Image(systemName: "externaldrive.badge.plus")
            })
            .listStyle(InsetGroupedListStyle())
        }
        .onAppear { self.viewModel.reloadServers() }
        .sheet(isPresented: $viewModel.isCreatingServer, content: {
            NavigationView {
                ServerSettingsView(viewModel: self.viewModel.createServerViewModel)
            }
            
        })
    }
}

struct ServersView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ServersViewModel(serverSelected: .init())
        viewModel.servers.append(contentsOf: (0...4).map { _ in MockServerManager(status: .disconnected) })
        return ServersView(viewModel: viewModel)
    }
}
