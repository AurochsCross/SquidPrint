//
//  PrinterManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine

public protocol PrinterManager {
    var status: CurrentValueSubject<PrinterStatus, Never> { get }
    var informationProvider: PrinterInformationProvider { get }
    var temperatureManager: PrinterTemperatureManager { get }
    
    func connect() -> AnyPublisher<Bool, Error>
}
