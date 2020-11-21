//
//  AppView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-19.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var viewModel: AppViewModel
    @State var showSettings = false
    
    var body: some View {
        Button(action: { self.showSettings.toggle()} ) {
            Text("Show settings")
        }
        .sheet(isPresented: $showSettings) {
            ServerSettingsView(viewModel: viewModel.serverSettingsViewModel)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(viewModel: AppViewModel(), showSettings: false)
    }
}
