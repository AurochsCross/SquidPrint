//
//  MockPrinterManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine

public class MockPrinterManager: PrinterManager {
    public let status = CurrentValueSubject<PrinterStatus, Never>(.connected)
    
    public let informationProvider: PrinterInformationProvider = MockPrinterInformationProvider()
    public let temperatureManager: PrinterTemperatureManager = MockPrinterTemperatureManager()
    public let temperatureProvider: PrinterTemperatureProvider = MockPrinterTemperatureProvider()
    
    public init() {
        
    }
    
    public func connect() -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
