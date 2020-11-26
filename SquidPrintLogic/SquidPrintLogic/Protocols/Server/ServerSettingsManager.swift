//
//  ServerSettings.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-23.
//

import Foundation
import Combine

internal protocol ServerSettingsManager {
    var serverSettingsManaged: CurrentValueSubject<DB_ServerSettings, Error> { get }
    var serverSettingsPublisher: AnyPublisher<ServerSettings, Error> { get }
    
    func updateServerSettings(_ serverSettings: ServerSettings) -> AnyPublisher<Void, Error>
    func deleteServer() -> AnyPublisher<Void, Error>
}
