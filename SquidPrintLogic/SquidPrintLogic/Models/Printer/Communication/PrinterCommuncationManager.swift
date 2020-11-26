//
//  PrinterCommuncationManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine
import OpenAPIClient

class PrinterCommunicationManager: ApiCallExecutor {
    let serverApiExecutor: ApiCallExecutor
    let printerStatus = CurrentValueSubject<PrinterStatus, Never>(.disconnected)
    
    init(serverApiExecutor: ApiCallExecutor) {
        self.serverApiExecutor = serverApiExecutor
    }
    
    func connect() -> AnyPublisher<Bool, Error> {
        execute(DefaultAPI.printerGet())
            .map { _ in
                if self.printerStatus.value != .connected {
                    self.printerStatus.value = .connected
                }
                return true
            }
            .eraseToAnyPublisher()
    }
    
    func execute<T>(_ call: AnyPublisher<T, Error>) -> AnyPublisher<T, Error> {
        serverApiExecutor.execute(call)
            .mapError { error -> Error in
                if let errorCode = (error as? ErrorResponse)?.errorCode {
                    if errorCode == 409 {
                        self.printerStatus.value = .disconnected
                    }
                }
                return error
            }
            .eraseToAnyPublisher()
    }
}
