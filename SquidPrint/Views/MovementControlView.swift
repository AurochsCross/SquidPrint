//
//  MovementControlView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI
import SquidPrintLogic

struct MovementControlView: View {
    @ObservedObject var viewModel: MovementControlViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    WidgetHolder(title: "Controlls") {
                        MovementControlWidget(onMove: viewModel.move)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(Text("Control"))
        }
    }
}

struct MovementControlView_Previews: PreviewProvider {
    static var previews: some View {
        MovementControlView(viewModel: MovementControlViewModel(serverManager: MockServerManager()))
    }
}
