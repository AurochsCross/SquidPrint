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
        if viewModel.appLoaded {
            if viewModel.isServerSetup {
                RootView(viewModel: viewModel.rootViewModel)
            } else {
                InitialServerSettingsView(viewModel: viewModel.serverSettingsViewModel)
            }
        } else {
            EmptyView()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(viewModel: AppViewModel(), showSettings: false)
    }
}
