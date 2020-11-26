//
//  StandaloneTemperatureGraphWidgetModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine
import SquidPrintLogic

class StandaloneTemperatureGraphWidgetModel: ObservableObject {
    @Published var hotendTargetTemperature: Int? = nil
    @Published var bedTargetTemperature: Int? = nil
    
    private let infoProvider: PrinterInformationProvider
    @Published private(set) var temperatures: [TemperatureFrame]
    private let temperatureBufferSize: Int

    private var cancellables = Set<AnyCancellable>()
    
    init(infoProvider: PrinterInformationProvider, bufferSize: Int) {
        self.temperatureBufferSize = bufferSize
        self.infoProvider = infoProvider
        self.temperatures = (0..<temperatureBufferSize).map { _ in TemperatureFrame() }
        
        infoProvider.printerState
            .receive(on: DispatchQueue.main)
            .sink { state in
                guard let temperature = state?.temperature else {
                    self.addTemperatureFrame(nil)
                    return
                }
                self.bedTargetTemperature = state?.temperature?.bed?.target.map { Int($0) }
                self.hotendTargetTemperature = state?.temperature?.tool0?.target.map { Int($0) }
                self.addTemperatureFrame(TemperatureFrame(temperatureState: temperature))
            }
            .store(in: &cancellables)
    }
    
    private func addTemperatureFrame(_ frame: TemperatureFrame?) {
        guard let frame = frame else {
            temperatures = Array(temperatures.dropFirst()) + [temperatures.last!]
            return
        }
        
        temperatures = Array(temperatures.dropFirst()) + [frame]
    }
}
