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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(viewModel: AppViewModel())
    }
}
