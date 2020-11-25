//
//  ProgressWidget.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI
import SquidPrintLogic

struct ProgressWidget: View {
    var body: some View {
        HStack {
            Circle()
                .stroke(Color.green, lineWidth: 10)
                .frame(width: 100, height: 100)
                .padding()
                .overlay(
                    Text("39%")
                        .font(.title)
                        .bold()
                        .foregroundColor(.green)
                )
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("Print time")
                        .bold()
                    Spacer()
                    Text("28") + Text("hr ").foregroundColor(.gray) +
                    Text("13") + Text("min ").foregroundColor(.gray)
                }
                HStack {
                    Text("Remaining time")
                        .bold()
                    Spacer()
                    Text("30:58")
                }
                HStack {
                    Text("Layer")
                        .bold()
                    Spacer()
                    Text("8 / 19")
                }
                HStack {
                    Text("Height")
                        .bold()
                    Spacer()
                    Text("12.2 / 22mm")
                }
            }
            .frame(maxHeight: .infinity)
        }
        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
    }
}

struct ProgressWidget_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModel(serverManager: MockServerManager()))
    }
}
