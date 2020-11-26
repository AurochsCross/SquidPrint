//
//  PrinterError.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import Foundation

enum PrinterError: Error {
    case busy
    case notConnected
    
    var userDescription: String {
        switch self {
        case .busy: return "Printer is busy"
        case .notConnected: return "Printer is not connected"
        }
    }
    
    var description: String {
        switch self {
        case .busy: return "Printer is busy"
        case .notConnected: return "Printer not connected"
        }
    }
}
