//
//  ServerManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-23.
//

import Foundation
import Combine
import OpenAPIClient

public protocol ServerManager {
    var id: Int { get }
    var name: String { get }
    var settings: ServerSettings { get }
    var status: CurrentValueSubject<ServerStatus, Never> { get }
    
    func connect() -> AnyPublisher<UserRecord, Error>
    
    func updateServerSettings(_ serverSettings: ServerSettings) -> AnyPublisher<ServerSettings, Error>
    func deleteServer() -> AnyPublisher<Void, Error>
}
