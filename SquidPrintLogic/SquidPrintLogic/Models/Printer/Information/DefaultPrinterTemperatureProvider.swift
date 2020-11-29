//
//  TemperatureInformationProvider.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-28.
//

import Foundation
import Combine
import OpenAPIClient

class DefaultPrinterTemperatureProvider: PrinterTemperatureProvider {
    
    let frames: CurrentValueSubject<[TemperatureFrame], Never>
    
    private let historySize: Int
    private let apiExecutor: ApiCallExecutor
    private var cancellables = Set<AnyCancellable>()
    
    private var initialHistoryState = ProcessState.notStarted
    
    init(printerState: CurrentValueSubject<FullState?, Never>, apiExecutor: ApiCallExecutor, historySize: Int) {
        self.apiExecutor = apiExecutor
        self.historySize = historySize
        frames = .init((0..<historySize).map { _ in TemperatureFrame() })
        printerState
            .map { state in
                TemperatureFrame(bed: state?.temperature?.bed, hotend: state?.temperature?.tool0, lastFrame: self.frames.value.last ?? TemperatureFrame())
            }
            .receive(on: DispatchQueue.main)
            .sink {
                if self.initialHistoryState == .finished {
                    self.frames.value = Array(self.frames.value.dropFirst()) + [$0]
                } else if self.initialHistoryState == .notStarted  {
                    self.retrieveHistory()
                    self.initialHistoryState = .inProgress
                }
            }
            .store(in: &cancellables)
    }
    
    public func retrieveHistory() {
        apiExecutor.execute(DefaultAPI.printerGet(history: true, limit: historySize))
            .sink(receiveCompletion: {
                switch $0 {
                case .finished: return
                case .failure(let error): log.error(error)
                }
            }) { result in
                let frames = result.history?.compactMap{ TemperatureFrame(bed: $0.bed, hotend: $0.tool0) } ?? []
                let missingFrames = self.historySize - frames.count
                
                self.frames.value = (0..<missingFrames).map { _ in frames.first ?? TemperatureFrame() } + frames
                self.initialHistoryState = .finished
            }
            .store(in: &cancellables)
    }
}
