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
    
    init(apiCallExecutor: ApiCallExecutor, printerStatus: AnyPublisher<PrinterStatus, Never>? = nil, refreshInterval: Double = 2) {
        self.refreshInterval = refreshInterval
        super.init(apiCallExecutor: apiCallExecutor)
        
        printerStatus?
            .sink { status in
                switch status {
                case .connected:
                    self.startRetrievingPrinterState()
                case .disconnected:
                    self.stopRetrievingPrinterState()
                }
            }
            .store(in: &cancellables)
    }
    
    
    private func startRetrievingPrinterState() {
        printerStatusCancellables = Set<AnyCancellable>()
        
        timer = Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true) { (timer) in
            self.apiExecutor.execute(DefaultAPI.printerGet())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        return
                    case .failure(let error):
                        log.error(error)
                        self.printerState.value = nil
                    }
                }, receiveValue: { state in
                    self.printerState.value = state
                })
                .store(in: &self.printerStatusCancellables)
        }
    }
    
    private func stopRetrievingPrinterState() {
        timer = nil
        printerStatusCancellables = Set<AnyCancellable>()
    }
}
