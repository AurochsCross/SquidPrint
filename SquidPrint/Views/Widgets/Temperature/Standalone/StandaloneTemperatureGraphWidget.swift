//
//  StandaloneTemperatureGraphWidget.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import SwiftUI
import SquidPrintLogic

struct StandaloneTemperatureGraphWidget: View {
    @ObservedObject var widgetModel: StandaloneTemperatureGraphWidgetModel
    
    var body: some View {
        TemperatureGraphWidget(temperatures: widgetModel.temperatures)
    }
}

struct StandaloneTemperatureGraphWidget_Previews: PreviewProvider {
    static var previews: some View {
        StandaloneTemperatureGraphWidget(widgetModel: StandaloneTemperatureGraphWidgetModel(infoProvider: MockPrinterManager().informationProvider, bufferSize: 40))
    }
}
