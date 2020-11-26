//
//  PrinterActionManager.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine

class PrinterApiCaller {
    let apiExecutor: ApiCallExecutor
    var cancellables = Set<AnyCancellable>()
    
    init(apiCallExecutor: ApiCallExecutor) {
        self.apiExecutor = apiCallExecutor
    }
}
