//
//  TemperatureFrame.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import OpenAPIClient

struct TemperatureFrame {
    var bed: Temperature
    var hotend: Temperature
    
    init() {
        bed = Temperature(actual: 0, target: 0, offset: 0)
        hotend = Temperature(actual: 0, target: 0, offset: 0)
    }
    
    init(temperatureState: TemperatureState) {
        hotend = temperatureState.tool0 ?? Temperature()
        bed = temperatureState.bed ?? Temperature()
    }
    
    init(bed: Temperature?, hotend: Temperature?, lastFrame: TemperatureFrame = TemperatureFrame()) {
        self.bed = bed ?? lastFrame.bed
        self.hotend = hotend ?? lastFrame.hotend
    }
}
