//
// PrinterState.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct PrinterState: Codable { 


    public var text: String?
    public var flags: PrinterStateFlags?

    public init(text: String? = nil, flags: PrinterStateFlags? = nil) {
        self.text = text
        self.flags = flags
    }

}
