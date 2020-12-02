//
//  DefaultPrinterManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine

class DefaultPrinterManager: PrinterManager {
    let informationProvider: PrinterInformationProvider
    let temperatureManager: PrinterTemperatureManager
    private let printerCommunicationManager: PrinterCommunicationManager
    
    private let serverStatus: CurrentValueSubject<ServerStatus, Never>
    
    var status: CurrentValueSubject<PrinterStatus, Never> {
        printerCommunicationManager.printerStatus
    }
    
    init(serverApiExecutor: ApiCallExecutor, serverStatus: CurrentValueSubject<ServerStatus, Never>) {
        self.serverStatus = serverStatus
        self.printerCommunicationManager = PrinterCommunicationManager(serverApiExecutor: serverApiExecutor)
        self.informationProvider = DefaultPrinterInformationProvider(apiCallExecutor: printerCommunicationManager, printerStatus: printerCommunicationManager.printerStatus.eraseToAnyPublisher())
        self.temperatureManager = DefaultPrinterTemperatureManager(apiCallExecutor: printerCommunicationManager)
    }
    
    func connect() -> AnyPublisher<Bool, Error> {
        printerCommunicationManager.connect()
    }
}
