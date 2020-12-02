//
//  TemperatureFrame.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-28.
//

import Foundation
import OpenAPIClient

public struct TemperatureFrame {
    public var bed: Temperature
    public var hotend: Temperature
    
    public init() {
        bed = Temperature(actual: 0, target: 0, offset: 0)
        hotend = Temperature(actual: 0, target: 0, offset: 0)
    }
    
    public init(temperatureState: TemperatureState) {
        hotend = temperatureState.tool0 ?? Temperature()
        bed = temperatureState.bed ?? Temperature()
    }
    
    public init(bed: Temperature?, hotend: Temperature?, lastFrame: TemperatureFrame = TemperatureFrame()) {
        self.bed = bed ?? lastFrame.bed
        self.hotend = hotend ?? lastFrame.hotend
    }
}
