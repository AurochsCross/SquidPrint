//
//  DefaultPrinterInformationProvider.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine
import OpenAPIClient

class DefaultPrinterInformationProvider: PrinterApiCaller, PrinterInformationProvider {
    let printerState = CurrentValueSubject<FullState?, Never>(nil)
    
    private var timer: Timer? = nil
    private let refreshInterval: Double
    private var printerStatusCancellables = Set<AnyCancellable>()
    
    let temperatureProvider: PrinterTemperatureProvider
    
    init(apiCallExecutor: ApiCallExecutor, printerStatus: AnyPublisher<PrinterStatus, Never>, refreshInterval: Double = 2) {
        self.refreshInterval = refreshInterval
        self.temperatureProvider = DefaultPrinterTemperatureProvider(apiExecutor: apiCallExecutor, printerStatus: printerStatus, refreshInterval: refreshInterval, historyBufferSize: 20)
        super.init(apiCallExecutor: apiCallExecutor)
    }
}
