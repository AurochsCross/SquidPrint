//
//  PrintheadHomingInstructions.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import Foundation
import OpenAPIClient

public struct PrintheadHomingInstructions: PrintheadInstructionSet {
    let homingAxis: HomingAxis
    
    public init(homingAxis: HomingAxis) {
        self.homingAxis = homingAxis
    }
    
    public func toApiInstructions() -> PrintHeadInstructions {
        PrintHeadInstructions(command: .home, axes: [] + (homingAxis == .xy ? [.x, .y] : []) + (homingAxis == .z ? [.z] : []))
    }
}
