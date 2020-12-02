//
//  ServerTemperatureManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import OpenAPIClient
import Combine

class DefaultPrinterTemperatureManager: PrinterApiCaller, PrinterTemperatureManager {
    func setTemperature(_ instructions: SetTemperatureInstructions) -> AnyPublisher<Void, Error> {
        if instructions.heatedPart == .bed {
            return apiExecutor.execute(bedTemperatureRequest(forTemperature: instructions.temperature))
        } else {
            return apiExecutor.execute(toolTemperatureRequest(forTemperature: instructions.temperature))
        }
    }
    
    private func bedTemperatureRequest(forTemperature temperature: Int) -> AnyPublisher<Void, Error> {
        DefaultAPI.printerBedPost(bedInstructions: BedInstructions(command: .target, target: Double(temperature)))
    }
    
    private func toolTemperatureRequest(forTemperature temperature: Int) -> AnyPublisher<Void, Error> {
        DefaultAPI.printerToolPost(printToolInstructions: PrintToolInstructions(command: .target, targets: PrintToolValues(tool0: Double(temperature))))
    }
}
