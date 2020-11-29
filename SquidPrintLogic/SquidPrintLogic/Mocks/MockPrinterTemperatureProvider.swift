//
//  MockPrinterTemperatureProvider.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-28.
//

import Foundation
import Combine

class MockPrinterTemperatureProvider: PrinterTemperatureProvider {
    var frames: CurrentValueSubject<[TemperatureFrame], Never> = .init([])
    
    func retrieveHistory() { }
}
