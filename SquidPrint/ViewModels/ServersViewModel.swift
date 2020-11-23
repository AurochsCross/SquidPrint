//
//  ServersViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import SquidPrintLogic

class ServersViewModel: ObservableObject {
    @Published var servers: [ServerManager] = []
    @Published var isCreatingServer = false
    
    private let serversManager: ServersManager
    private(set) var createServerViewModel: ServerSettingsViewModel!
    
    private let serverSelectedSubject: PassthroughSubject<ServerManager, Never>
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverSelected: PassthroughSubject<ServerManager, Never>) {
        serversManager = serviceContainer.serversManager
        serverSelectedSubject = serverSelected
        
        serversManager.servers
            .assertNoFailure()
            .assign(to: \.servers, on: self)
            .store(in: &cancellables)
    }
    
    func select(server: ServerManager) {
        serverSelectedSubject.send(server)
    }
    
    func createServer() {
        let onSave = PassthroughSubject<ServerSettings, Never>()
        onSave
            .flatMap { settings in
                    return self.serversManager.addServer(serverSettings: settings)
            }
            .sink(receiveCompletion: { log.completion($0, taskName: "Create server") }) { settings in
                self.isCreatingServer = false
            }
            .store(in: &cancellables)
        
        createServerViewModel = ServerSettingsViewModel(onSave: onSave)
        isCreatingServer = true
    }
    
    func reloadServers() {
        serversManager.loadServers()
    }
}
