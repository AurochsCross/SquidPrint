//
//  GenericError.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation

public enum GenericError: Error {
    case notImplemented
    case unknown
    
    public var localizedDescription: String {
        switch self {
        case .notImplemented: return "Not implemented"
        case .unknown: return "Unknown"
        }
    }
    
    public var userDescription: String {
        switch self {
        case .notImplemented: return "Not implemented"
        case .unknown: return "Unknown"
        }
    }
}
