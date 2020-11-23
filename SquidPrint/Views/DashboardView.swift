//
//  DashboardView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                Circle()
                    .stroke(Color.green, lineWidth: 10)
                    .frame(height: 300)
                    .padding()
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
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
