//
//  SettingsViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-23.
//

import Foundation
import Combine
import SquidPrintLogic

class SettingsViewModel: ObservableObject {
    private(set) var serverSettingsViewModel: ServerSettingsViewModel
    let serverManager: ServerManager
    @Published var serverConfiguration: ServerSettings
    
    @Published var showServerSettings = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
        serverConfiguration = serverManager.settings
        
        let settingsSaved = PassthroughSubject<ServerSettings, Never>()
        serverSettingsViewModel = ServerSettingsViewModel(currentSettings: serverManager.settings, onSave: settingsSaved)
        
        settingsSaved
            .flatMap { settings in
                serverManager.updateServerSettings(settings)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    log.info("Settings updated")
                case .failure(let error): log.error(error)
                }
            }) { settings in
                self.showServerSettings = false
                self.serverConfiguration = serverManager.settings
                self.serverSettingsViewModel = ServerSettingsViewModel(currentSettings: settings, onSave: settingsSaved)
            }
            .store(in: &cancellables)
    }
    
    func deleteServer(_ environemnt: AppEnvironment) {
        serverManager.deleteServer()
            .catch { error -> Just<Void> in
                log.error(error)
                return Just<Void>(())
            }
            .receive(on: DispatchQueue.main)
            .sink { _ in
                environemnt.reloadServers()
                self.switchServer(environemnt) }
            .store(in: &cancellables)
    }
    
    func switchServer(_ environemnt: AppEnvironment) {
        environemnt.selectServer(nil)
    }
}
