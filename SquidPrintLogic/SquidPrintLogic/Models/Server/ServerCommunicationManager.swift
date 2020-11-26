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
    let status = CurrentValueSubject<ServerStatus, Never>(.disconnected)
    private var cancellables = Set<AnyCancellable>()
    
    init(serverSettings: ServerSettings) {
        self.serverSettings = serverSettings
    }
    
    private func handleError<T>(on call: AnyPublisher<T, Error>) -> AnyPublisher<T, Error> {
        call
            .mapError { error -> Error in
                if let errorCode = (error as? ErrorResponse)?.errorCode {
                    if errorCode != 409 {
                        self.status.value = .disconnected
                    }
                }
                log.error(error)
                return error
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Actions
extension ServerCommunicationManager {
    func connect() -> AnyPublisher<UserRecord, Error> {
        OpenAPIClientAPI.setSettings(forServer: serverSettings)
        
        return AuthenticationAPI.loginPost(
            loginRequest: LoginRequest(
                passive: true))
            .map { response in
                self.status.value = .connected
                return response
            }
            .mapError { error in
                self.status.value = .disconnected
                return error
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - ApiCallExecutor
extension ServerCommunicationManager: ApiCallExecutor {
    func execute<T>(_ call: AnyPublisher<T, Error>) -> AnyPublisher<T, Error> {
        OpenAPIClientAPI.setSettings(forServer: serverSettings)
        return handleError(on: call)
    }
}
