//
//  ServersView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import SwiftUI

struct ServersView: View {
    @ObservedObject var viewModel: ServersViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.servers) { server in
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
        .sheet(isPresented: $viewModel.isCreatingServer, content: { CreateServerView(viewModel: self.viewModel.createServerViewModel) })
    }
}

struct ServersView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ServersViewModel(serverSelected: .init())
        ServersView(viewModel: viewModel)
    }
}
