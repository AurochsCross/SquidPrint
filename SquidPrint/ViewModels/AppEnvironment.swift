//
//  AppViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import SquidPrintLogic

class AppEnvironment: ObservableObject {
    @Published var selectedServer: ServerManager? = nil
    @Published var isAppLoaded = false
    
    private(set) var serverViewModel: ServerRootViewModel? = nil
    
    let serversViewModel: ServersViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let serverSelected = PassthroughSubject<ServerManager, Never>()
        
        serversViewModel = ServersViewModel(serverSelected: serverSelected)
        
        serverSelected
            .receive(on: DispatchQueue.main)
            .sink {
                self.selectServer($0)
            }
            .store(in: &cancellables)
        
        serviceContainer.coreDataStorage.isStorageLoaded
            .catch { error -> Just<Bool> in
                log.error(error)
                return Just(false)
            }
            .assign(to: \.isAppLoaded, on: self)
            .store(in: &cancellables)
    }
    
    func selectServer(_ server: ServerManager?) {
        guard let server = server else {
            serverViewModel = nil
            selectedServer = nil
            return
        }
        
        serverViewModel = ServerRootViewModel(serverManager: server)
        selectedServer = server
    }
    
    func reloadServers() {
        serversViewModel.reloadServers()
    }
}
