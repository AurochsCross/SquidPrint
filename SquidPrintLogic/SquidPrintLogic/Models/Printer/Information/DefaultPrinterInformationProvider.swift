//
//  DefaultPrinterInformationProvider.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine
import OpenAPIClient

class DefaultPrinterInformationProvider: PrinterInformationProvider {
    let printerState = CurrentValueSubject<FullState?, Never>(nil)
    
    private var stateUpdateCancellables = Set<AnyCancellable>()
    private var timer: Timer? = nil
    private let refreshInterval: Double
    
    private let apiExecutor: ApiCallExecutor
    
    init(apiCallExecutor: ApiCallExecutor, refreshInterval: Double = 1) {
        self.apiExecutor = apiCallExecutor
        self.refreshInterval = 1.0
    }
    
    private func startRetrievingPrinterState() {
        stateUpdateCancellables = Set<AnyCancellable>()
        
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
                .store(in: &self.stateUpdateCancellables)
        }
    }
    
    private func stopRetrievingPrinterState() {
        timer = nil
        stateUpdateCancellables = Set<AnyCancellable>()
    }
}
