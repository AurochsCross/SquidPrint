//
//  CoreDataError.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation

public enum CoreDataError: Error {
    case dataMissing
    case saveFailed
    
    public var localizedDescription: String {
        switch self {
        case .dataMissing: return "Data missing"
        case .saveFailed: return "Save failed"
        }
    }
    
    public var userDescription: String {
        switch self {
        case .dataMissing: return "Data is missing"
        case .saveFailed: return "Save operation have failed"
        }
    }
}
