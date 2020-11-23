//
//  AppView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-19.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var viewModel: AppViewModel
    
    var body: some View {
        if viewModel.isAppLoaded {
            if let serverViewModel = viewModel.serverViewModel {
                ServerRootView(viewModel: serverViewModel)
            } else {
                ServersView(viewModel: viewModel.serversViewModel)
            }
        } else {
            Text("SquidPrint")
                .font(.largeTitle)
                .fontWeight(.black)
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = AppViewModel()
        viewModel.isAppLoaded = true
        return AppView(viewModel: viewModel)
    }
}
