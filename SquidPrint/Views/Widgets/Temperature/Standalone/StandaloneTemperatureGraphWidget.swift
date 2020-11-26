//
//  StandaloneTemperatureGraphWidget.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import SwiftUI

struct StandaloneTemperatureGraphWidget: View {
    var body: some View {
        TemperatureGraphWidget(temperatures: [])
    }
}

struct StandaloneTemperatureGraphWidget_Previews: PreviewProvider {
    static var previews: some View {
        StandaloneTemperatureGraphWidget()
    }
}
