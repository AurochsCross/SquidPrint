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
    @Published var apiKey: String
    @Published var serverSettings: ServerSettings?
    private let serverManager: ServerManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverManager: ServerManager) {
        apiKey = ""
        self.serverManager = serverManager
    }
    
    func onAppear() {
        reloadSettings()
    }
    
    func onSave() {
        guard let serverSettings = serverSettings else {
            return
        }
        
        serverSettings.apiKey = apiKey.isEmpty ? nil : apiKey
        serverManager.updateServerSettings(serverSettings)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: print("finished good")
                case .failure(let error): print("Failed: \(error)")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    private func reloadSettings() {
        serverManager.serverSettingsPublisher
            .catch { error -> Just<ServerSettings> in
                print("Error: \(error)")
                return Just(ServerSettings())
            }
            .receive(on: DispatchQueue.main)
            .sink { result in
                self.serverSettings = result
                self.apiKey = result.apiKey ?? ""
            }
            .store(in: &cancellables)
    }
}
