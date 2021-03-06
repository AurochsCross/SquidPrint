//
// PrintHeadInstructions.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation


public struct PrintHeadInstructions: Codable { 


    public enum Axes: String, Codable, CaseIterable {
        case x = "x"
        case y = "y"
        case z = "z"
    }
    public var command: PrintHeadCommand
    public var x: Double?
    public var y: Double?
    public var z: Double?
    public var axes: [Axes]?

    public init(command: PrintHeadCommand, x: Double? = nil, y: Double? = nil, z: Double? = nil, axes: [Axes]? = nil) {
        self.command = command
        self.x = x
        self.y = y
        self.z = z
        self.axes = axes
    }

}
