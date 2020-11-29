//
//  PrinterContinuousInformationProvider.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-29.
//

import Foundation
import Combine

class PrinterContinuousInformationProvider<T> {
    public var informationSubject: PassthroughSubject<T, Never>

    internal var informationReceivePublisher: AnyPublisher<T, Error> { fatalError("Not implemented") }
    
    internal var cancellables = Set<AnyCancellable>()
    private var informationCancellables = Set<AnyCancellable>()
    private let refreshInterval: Double
    private var timer: Timer? = nil
    private let apiExecutor: ApiCallExecutor
    
    init(apiExecutor: ApiCallExecutor, printerStatus: AnyPublisher<PrinterStatus, Never>, refreshInterval: Double) {
        self.refreshInterval = refreshInterval
        self.apiExecutor = apiExecutor
        self.informationSubject = PassthroughSubject<T, Never>()
        
        printerStatus
            .sink { status in
                if status == .connected {
                    self.startRetrievingInformation()
                } else {
                    self.stopRetrievingInformation()
                }
            }
            .store(in: &cancellables)
    }
    
    private func startRetrievingInformation() {
        timer = Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true) { (timer) in
            self.apiExecutor.execute(self.informationReceivePublisher)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        return
                    case .failure(let error):
                        log.error(error)
                    }
                }, receiveValue: { information in
                    self.informationSubject.send(information)
                })
                .store(in: &self.informationCancellables)
        }
    }
    
    private func stopRetrievingInformation() {
        timer = nil
        informationCancellables = Set<AnyCancellable>()
    }
}
