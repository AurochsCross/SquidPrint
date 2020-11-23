//
//  AppViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import SquidPrintLogic

class AppViewModel: ObservableObject {
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
                self.serverViewModel = ServerRootViewModel(serverManager: $0)
                self.selectedServer = $0
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
}
