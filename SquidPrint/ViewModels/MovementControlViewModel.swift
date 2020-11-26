//
//  MovementControlViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import Foundation
import Combine
import SquidPrintLogic

class MovementControlViewModel: ObservableObject {
    private let serverManager: ServerManager
    private var cancellables = Set<AnyCancellable>()
    
    init(serverManager: ServerManager) {
        self.serverManager = serverManager
    }
    
    func move(withInstructions instructions: PrintheadInstructionSet) {
        serverManager.move(withInstructions: instructions)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: return
                case .failure(let error):
                    log.error(error)
                    AlertUtility.display(error: error)
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
        
    }
}
