//
//  MockServerManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-23.
//

import Foundation
import Combine
import OpenAPIClient

public class MockServerManager: ServerManager {
    public var id: Int { Int.random(in: 0...9999) }
    public var name: String { UUID().uuidString }
    public var settings: ServerSettings {
        ServerSettings(
            name: String(UUID().uuidString.replacingOccurrences(of: "-", with: "").prefix(Int.random(in: 4...12))),
            address: "\(Int.random(in: 0...255)).\(Int.random(in: 0...255)).\(Int.random(in: 0...255)).\(Int.random(in: 0...255))",
            port: Bool.random() ? "\(Int.random(in: 0...255))" : nil,
            apiKey: String(UUID().uuidString.replacingOccurrences(of: "-", with: "")))
    }
    
    public let status: CurrentValueSubject<ServerStatus, Never>

    public func connect() -> AnyPublisher<UserRecord, Error> {
        fatalError()
    }
    
    public func updateServerSettings(_ serverSettings: ServerSettings) -> AnyPublisher<ServerSettings, Error> {
        return PublisherUtilities.anyWithValue(serverSettings)
    }
    
    public func deleteServer() -> AnyPublisher<Void, Error> {
        return PublisherUtilities.anyWithValue(())
    }
    
    public init(status: ServerStatus = .connected) {
        self.status = .init(status)
    }
    
    public func move(withInstructions instructions: PrintheadInstructionSet) -> AnyPublisher<Void, Error> {
        fatalError()
    }
}
