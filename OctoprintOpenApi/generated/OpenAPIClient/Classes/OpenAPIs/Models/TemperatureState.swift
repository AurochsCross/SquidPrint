//
// TemperatureState.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct TemperatureState: Codable { 


    public var tool0: Temperature?
    public var bed: Temperature?

    public init(tool0: Temperature? = nil, bed: Temperature? = nil) {
        self.tool0 = tool0
        self.bed = bed
    }

}
