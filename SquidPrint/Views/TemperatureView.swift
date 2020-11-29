//
//  TemperatureView.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import SwiftUI
import SquidPrintLogic

struct TemperatureView: View {
    @ObservedObject var viewModel: TemperatureViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    StandaloneTemperatureGraphWidget(widgetModel: viewModel.temperatureGraphWidget)
                        .frame(height: 200)
                        .padding(.horizontal)
                    VStack {
                        WidgetHolder(title: "Target temperature") {
                            TemperatureControllWidget(
                                title: "Hotend",
                                currentTemperature: $viewModel.hotendTargetTemperature,
                                maxTemperature: 250,
                                color: .orange,
                                onTemperatureChanged: { self.viewModel.setTemperature(for: .hotend, to: $0) })
                        }
                        WidgetHolder {
                            TemperatureControllWidget(
                                title: "Bed",
                                currentTemperature: $viewModel.bedTargetTemperature,
                                maxTemperature: 100,
                                color: .blue,
                                onTemperatureChanged: { self.viewModel.setTemperature(for: .bed, to: $0) })
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle(Text("Temperature"))
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(viewModel: TemperatureViewModel(printerManager: MockPrinterManager()))
            .preferredColorScheme(.dark)
    }
}
