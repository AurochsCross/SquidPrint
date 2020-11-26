//
//  ErrorHandler.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import XCGLogger
import OpenAPIClient

extension Error {
    public var description: String {
        if let error = self as? GenericError { return error.description }
        if let error = self as? CoreDataError { return error.description }
        if let error = self as? PrinterError { return error.description }
        if let error = self as? ErrorResponse { return error.description }
        
        return self.localizedDescription
    }
    
    public var userDescription: String {
        if let error = self as? GenericError { return error.userDescription }
        if let error = self as? CoreDataError { return error.userDescription }
        if let error = self as? PrinterError { return error.userDescription }
        if let error = self as? ErrorResponse { return error.userDescription }
        
        return self.localizedDescription
    }
}

extension XCGLogger {
    public func error(_ error: Error) {
        self.error(error.description)
    }
}

extension ErrorResponse {
    public var description: String {
        switch self {
        case .error(let code, let data, let error):
            return description(fromCode: code, data: data, error: error)
        }
    }
    
    public var userDescription: String {
        switch self {
        case .error(let code, let data, let error):
            return userDescription(fromCode: code, data: data, error: error)
        }
    }
    
    var errorCode: Int {
        switch self {
        case .error(let code, _, _):
            return code
        }
    }
    
    private func description(fromCode code: Int, data: Data?, error: Error) -> String {
        if let data = data, let message = String(data: data, encoding: .utf8) {
            return "[\(code)] \(message)"
        }
        
        return "[\(code)] No error message"
    }
    
    private func userDescription(fromCode code: Int, data: Data?, error: Error) -> String {
        if let data = data, let message = String(data: data, encoding: .utf8) {
            return "\(message)"
        }
        
        return "Something went wrong"
    }
}
