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
    
    private let temperatureProvider: PrinterTemperatureProvider
    @Published private(set) var temperatures: [TemperatureFrame]
    private let temperatureBufferSize: Int

    private var cancellables = Set<AnyCancellable>()
    
    init(infoProvider: PrinterInformationProvider, bufferSize: Int) {
        self.temperatureBufferSize = bufferSize
        self.temperatureProvider = infoProvider.temperatureProvider
        self.temperatures = (0..<temperatureBufferSize).map { _ in TemperatureFrame() }
        
        temperatureProvider.frames
            .receive(on: DispatchQueue.main)
            .assign(to: \.temperatures, on: self)
            .store(in: &cancellables)
    }
}
