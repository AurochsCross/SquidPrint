//
//  TemperatureWidget.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-24.
//

import SwiftUI
import SquidPrintLogic

struct TemperatureWidget: View {
    var body: some View {
        HStack {
            HotEndAnimation(color: Color.primary)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Hotend")
                        .bold()
                    Spacer()
                    Text("205°C")
                }
                HStack {
                    Text("Bed")
                        .bold()
                    Spacer()
                    Text("61°C")
                }
                HStack {
                    Text("Fan")
                        .bold()
                    Spacer()
                    Text("100%")
                }
            }
            Spacer()
            
        }
    }
}

struct TemperatureWidget_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModel(serverManager: MockServerManager()))
            .preferredColorScheme(.dark)
    }
}
