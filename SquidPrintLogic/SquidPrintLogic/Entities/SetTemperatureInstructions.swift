//
//  SetTemperatureInstructions.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation

public struct SetTemperatureInstructions {
    let heatedPart: HeatedPart
    let temperature: Int
    
    public init(part: HeatedPart, temperature: Int) {
        self.heatedPart = part
        self.temperature = temperature
    }
}
