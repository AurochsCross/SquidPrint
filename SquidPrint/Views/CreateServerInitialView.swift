//
//  CreateServerInitialView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import SwiftUI

struct CreateInitialServerView: View {
    @ObservedObject var viewModel: ServerSettingsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("SquidPrint")
                    .font(.largeTitle)
                    .font(.title)
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: geometry.size.height / 3.0)

                VStack {
                    Text("Server Setup")
                        .font(.title)

                    VStack {
                        TextField("Name", text: $viewModel.name)
                        Divider()
                        HStack {
                            TextField("Address *", text: $viewModel.address)
                                .keyboardType(.URL)
                            TextField("Port", text: $viewModel.port)
                                .keyboardType(.numberPad)
                                .frame(width: 50)
                        }
                        Divider()
                        TextField("API Key *", text: $viewModel.apiKey)
                    }
                    .padding()
                    .background(Color(.sRGB, white: 0.5, opacity: 0.1))
                    .cornerRadius(6)

                    HStack {
                        Spacer()
                        Button(action: self.viewModel.onSave) {
                            Text("Connect")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("PrimaryColor"))
                        }
                        .cornerRadius(6)

                    }
                }
                .frame(maxWidth: 300)
            }
        }
        
    }
}

struct CreateInitialServerView_Previews: PreviewProvider {
    static var previews: some View {
        ServerSettingsView(viewModel: ServerSettingsViewModel(onSave: .init()))
    }
}
