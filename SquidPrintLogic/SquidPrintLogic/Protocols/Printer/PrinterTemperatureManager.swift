//
//  PrinterTemperatureControler.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine

public protocol PrinterTemperatureManager {
    func setTemperature(_ instructions: SetTemperatureInstructions) -> AnyPublisher<Void, Error>
}
