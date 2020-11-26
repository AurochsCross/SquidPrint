//
//  DashboardViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import SquidPrintLogic

class DashboardViewModel: ObservableObject {
    @Published var isConnected = false
    
    let serverManager: ServerManager
    let temperatureWidgetModel: StandaloneTemperatureGraphWidgetModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
        self.temperatureWidgetModel = StandaloneTemperatureGraphWidgetModel(infoProvider: serverManager.printerManager.informationProvider, bufferSize: 40)
        
        serverManager.status
            .map { status in
                status == .connected
            }
            .assign(to: \.isConnected, on: self)
            .store(in: &cancellables)
    }
    
    func connect() {
        if isConnected { return }
        
        serverManager.connect()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: log.info("Connected successfuly")
                case .failure(let error): log.error(error)
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
