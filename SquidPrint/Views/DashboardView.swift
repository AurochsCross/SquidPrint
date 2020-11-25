//
//  DashboardView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import SwiftUI
import SquidPrintLogic

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Progress")) {
                    ProgressWidget()
                }
                
                Section(header: Text("Readings")) {
                    TemperatureWidget()
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
                
                Section(header: Text("Temperature")) {
                    HStack {
                        Text("Hot End")
                        Spacer()
                        Text("205°C")
                            .foregroundColor(.red)
                    }
                    HStack {
                        Text("Bed")
                        Spacer()
                        Text("61°C")
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("Temperature graph")) {
                    TemperatureGraphWidget()
                        .frame(height: 250)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Dashboard")
            .navigationBarItems(trailing: HStack {
                EmptyView()
                if !self.viewModel.isConnected {
                    Button(action: self.viewModel.connect) {
                        Image(systemName: "externaldrive.badge.xmark")
                            .foregroundColor(.red)
                    }
                }
            })
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModel(serverManager: MockServerManager()))
    }
}
