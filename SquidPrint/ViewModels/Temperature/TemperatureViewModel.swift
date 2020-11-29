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
        
        infoProvider.temperatureProvider.frames
            .receive(on: DispatchQueue.main)
            .sink { frames in
                guard frames.last?.bed.target.map({ Int($0) }) ?? self.bedTargetTemperature != self.bedTargetTemperature
                        || frames.last?.hotend.target.map({ Int($0) }) ?? self.hotendTargetTemperature != self.hotendTargetTemperature else {
                    return
                }
                
                self.bedTargetTemperature = frames.last?.bed.target.map { Int($0) }
                self.hotendTargetTemperature = frames.last?.hotend.target.map { Int($0) }
                    
                
                self.objectWillChange.send()
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
