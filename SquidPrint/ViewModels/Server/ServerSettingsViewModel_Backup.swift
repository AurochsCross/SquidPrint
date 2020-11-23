//
//  ServerSettingsViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-23.
//

import Foundation
import Combine
import SquidPrintLogic

class ServerSettingsViewModel_Backup: ObservableObject {
    let serverManager: ServerManager
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var port: String = ""
    @Published var apiKey: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
    }
    
    func onUpdate() {
        serverManager.updateServerSettings(ServerSettings(name: name, address: address, port: port, apiKey: apiKey))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: log.info("Updated server settings")
                case .failure(let error): log.error(error)
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
