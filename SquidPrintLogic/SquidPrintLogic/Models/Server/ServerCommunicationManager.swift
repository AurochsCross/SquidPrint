//
//  ServerCommunicationManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-24.
//

import Foundation
import Combine
import OpenAPIClient

class ServerCommunicationManager {
    let serverSettings: ServerSettings
    let isConnected = CurrentValueSubject<Bool, Never>(false)
    let printerStatus = CurrentValueSubject<PrinterCommunicationStatus, Never>(.disconnected)
    let printerState = CurrentValueSubject<FullState?, Never>(nil)
    
    private var cancellables = Set<AnyCancellable>()
    private var stateUpdateCancellables = Set<AnyCancellable>()
    private var timer: Timer? = nil
    
    init(serverSettings: ServerSettings) {
        self.serverSettings = serverSettings
        
        isConnected
            .sink { isConnected in
                if isConnected {
                    self.startRetrievingPrinterState()
                } else {
                    self.stopRetrievingPrinterState()
                }
            }
            .store(in: &cancellables)
    }
    
    func connect() -> AnyPublisher<UserRecord, Error> {
        OpenAPIClientAPI.setSettings(forServer: serverSettings)
        
        return AuthenticationAPI.loginPost(
            loginRequest: LoginRequest(
                passive: true))
            .map { response in
                self.isConnected.value = true
                return response
            }
            .mapError { error in
                self.isConnected.value = false
                return error
            }
            .eraseToAnyPublisher()
    }
    
    private func startRetrievingPrinterState() {
        stateUpdateCancellables = Set<AnyCancellable>()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.execute(DefaultAPI.printerGet())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        if self.printerStatus.value != .connected {
                            self.printerStatus.value = .connected
                        }
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
    
    private func handleError<T>(on call: AnyPublisher<T, Error>) -> AnyPublisher<T, Error> {
        call
            .mapError { error -> Error in
                if let errorCode = (error as? ErrorResponse)?.errorCode {
                    if errorCode == 409 {
                        self.printerStatus.value = .disconnected
                    }
                }
                log.error(error)
                return error
            }
            .eraseToAnyPublisher()
    }
}

extension ServerCommunicationManager: ApiCallExecutor {
    func execute<T>(_ call: AnyPublisher<T, Error>) -> AnyPublisher<T, Error> {
        OpenAPIClientAPI.setSettings(forServer: serverSettings)
        return handleError(on: call)
    }
}
