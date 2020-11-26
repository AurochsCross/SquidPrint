//
//  TemperatureViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine
import OpenAPIClient
import SquidPrintLogic

class TemperatureViewModel: ObservableObject {
    @Published var hotendTargetTemperature: Int? = nil
    @Published var bedTargetTemperature: Int? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let infoProvider: PrinterInformationProvider
    private let temperatureManager: PrinterTemperatureManager
    let temperatureGraphWidget: StandaloneTemperatureGraphWidgetModel
    
    init(printerManager: PrinterManager) {
        self.infoProvider = printerManager.informationProvider
        self.temperatureManager = printerManager.temperatureManager
        self.temperatureGraphWidget = StandaloneTemperatureGraphWidgetModel(infoProvider: printerManager.informationProvider, bufferSize: 40)
        
        infoProvider.printerState
            .receive(on: DispatchQueue.main)
            .sink { state in
                self.bedTargetTemperature = state?.temperature?.bed?.target.map { Int($0) }
                self.hotendTargetTemperature = state?.temperature?.tool0?.target.map { Int($0) }
            }
            .store(in: &cancellables)
    }
    
    func setTemperature(for heatedPart: HeatedPart, to temperature: Int) {
        let instructions = SetTemperatureInstructions(part: heatedPart, temperature: temperature)
        temperatureManager.setTemperature(instructions)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: log.info("Temperature set")
                case .failure(let error):
                    log.error(error)
                    AlertUtility.display(error: error)
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
    }
}
