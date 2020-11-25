//
//  Log+Completion.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import XCGLogger
import Combine

extension XCGLogger {
    public func completion(_ completion: Subscribers.Completion<Error>, taskName: String? = nil) {
        switch completion {
        case .failure(let error): log.error(error)
        case .finished: log.info("\(taskName ?? "Task ") finished successfuly")
        }
    }
}
