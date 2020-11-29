//
//  TemperatureInformationProvider.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-28.
//

import Foundation
import Combine
import OpenAPIClient

class DefaultPrinterTemperatureProvider: PrinterContinuousInformationProvider<[TemperatureFrame]>, PrinterTemperatureProvider {
    var frames: CurrentValueSubject<[TemperatureFrame], Never>
    
    override var informationReceivePublisher: AnyPublisher<[TemperatureFrame], Error> {
        if initialHistoryProcessStatus == .notStarted {
            initialHistoryProcessStatus = .inProgress
            
            return DefaultAPI.printerGet(history: true, limit: historyBufferSize)
                .map { state -> [TemperatureFrame] in
                    self.initialHistoryProcessStatus = .finished
                    return (state.temperature?.history ?? []).compactMap { TemperatureFrame(bed: $0.bed, hotend: $0.tool0) }
                }
                .eraseToAnyPublisher()
        } else if initialHistoryProcessStatus == .inProgress {
            return Empty<[TemperatureFrame], Error>().eraseToAnyPublisher()
        } else {
            return DefaultAPI.printerGet(history: true, limit: historyBufferSize)
                .map { state -> [TemperatureFrame] in
                    [ TemperatureFrame(bed: state.temperature?.bed, hotend: state.temperature?.tool0) ]
                }
                .eraseToAnyPublisher()
        }
    }
    
    private let historyBufferSize: Int
    private var initialHistoryProcessStatus = ProcessStatus.notStarted
    
    init(
        apiExecutor: ApiCallExecutor,
        printerStatus: AnyPublisher<PrinterStatus, Never>,
        refreshInterval: Double,
        historyBufferSize: Int) {
        self.historyBufferSize = historyBufferSize
        self.frames = .init((0..<historyBufferSize).map { _ in TemperatureFrame() })
        super.init(
            apiExecutor: apiExecutor,
            printerStatus: printerStatus,
            refreshInterval: refreshInterval)
        
        informationSubject
            .map { frames in
                Array(self.frames.value.dropFirst(frames.count)) + frames
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error): log.error(error)
                case .finished: return
                }
            }, receiveValue: {
                self.frames.value = $0
            })
            .store(in: &cancellables)
    }
    
    func retrieveHistory() {
        initialHistoryProcessStatus = .notStarted
    }
}
