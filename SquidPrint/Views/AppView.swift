//
//  AppView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-19.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var environment: AppEnvironment
    
    var body: some View {
        ZStack {
            if environment.isAppLoaded {
                if let serverViewModel = environment.serverViewModel {
                    ServerRootView(viewModel: serverViewModel)
                        .environmentObject(environment)
                } else {
                    ServersView(viewModel: environment.serversViewModel)
                        .environmentObject(environment)
                }
            } else {
                Text("SquidPrint")
                    .font(.largeTitle)
                    .fontWeight(.black)
            }
        }
        .animation(.default)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        let environment = AppEnvironment()
        environment.isAppLoaded = true
        return AppView(environment: environment)
    }
}
