//
//  MoveCommand.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import Foundation
import OpenAPIClient

public struct PrintheadMoveInstructions: PrintheadInstructionSet {
    public func toApiInstructions() -> PrintHeadInstructions {
        PrintHeadInstructions(
            command: .jog,
            x: axis == .x ? step : nil,
            y: axis == .y ? step : nil,
            z: axis == .z ? step : nil,
            axes: nil)
    }
    
    public var axis: MoveAxis
    public var step: Double
    
    public init(axis: MoveAxis, step: Double) {
        self.axis = axis
        self.step = step
    }
}
