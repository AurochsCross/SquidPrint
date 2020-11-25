//
//  MovementControlView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI

struct MovementControlView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    WidgetHolder(title: "Controlls") {
                        MovementControlWidget()
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
        MovementControlView()
    }
}
