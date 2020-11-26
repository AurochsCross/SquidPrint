//
//  ServerMovementManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import Foundation
import OpenAPIClient
import Combine

class ServerMovementManager {
    let callExecutor: ApiCallExecutor
    
    private var isBusy = false
    
    init(callExecutor: ApiCallExecutor) {
        self.callExecutor = callExecutor
    }
    
    func issuePrintheadMovementCommand(_ instructions: PrintheadInstructionSet) -> AnyPublisher<Void, Error> {
        if isBusy {
            return Fail<Void, Error>(error: PrinterError.busy).eraseToAnyPublisher()
        }
        
        isBusy = true
        
        return callExecutor.execute(DefaultAPI.printerPrintheadPost(printHeadInstructions: instructions.toApiInstructions()))
            .mapError {
                self.isBusy = false
                return $0
            }
            .map { _ in
                self.isBusy = false
                return ()
            }
            .eraseToAnyPublisher()
    }
}
