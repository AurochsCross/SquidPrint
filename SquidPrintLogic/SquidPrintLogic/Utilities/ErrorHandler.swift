//
//  ErrorHandler.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import XCGLogger

extension Error {
    public var description: String {
        if let error = self as? GenericError { return error.localizedDescription }
        if let error = self as? CoreDataError { return error.localizedDescription }
        
        return self.localizedDescription
    }
    
    public var userDescription: String {
        if let error = self as? GenericError { return error.userDescription }
        if let error = self as? CoreDataError { return error.userDescription }
        
        return self.localizedDescription
    }
}

extension XCGLogger {
    public func error(_ error: Error) {
        self.error(error.description)
    }
}
