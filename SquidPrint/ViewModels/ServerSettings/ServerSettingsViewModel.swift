//
//  ServerSettingsViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import SquidPrintLogic
import Combine

class ServerSettingsViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var apiKey: String = ""
    @Published var address: String = ""
    @Published var port: String = ""
    private let serverManager: ServerManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
    }
    
    func onAppear() {
        reloadSettings()
    }
    
    func onSave() {
        let serverSettings = ServerSettings(
            name: name,
            address: address,
            port: port,
            apiKey: apiKey)
        
        serverManager.updateServerSettings(serverSettings)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: log.info("finished good")
                case .failure(let error): log.error("Failed: \(error)")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    func onDeleteServer() {
        serverManager.deleteServer()
    }
    
    private func reloadSettings() {
        serverManager.serverSettingsPublisher
            .catch { error -> Just<ServerSettings> in
                log.error("\(error)")
                return Just(ServerSettings())
            }
            .receive(on: DispatchQueue.main)
            .sink { result in
                self.setFields(fromSettings: result)
            }
            .store(in: &cancellables)
    }
    
    private func setFields(fromSettings settings: ServerSettings) {
        self.name = settings.name ?? ""
        self.address = settings.address
        self.port = settings.port ?? ""
        self.apiKey = settings.apiKey
    }
}
