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
    
    init(serverSettings: ServerSettings) {
        self.serverSettings = serverSettings
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
}
