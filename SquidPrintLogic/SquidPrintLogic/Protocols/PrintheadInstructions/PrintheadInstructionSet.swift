//
//  PrintheadInstructionSet.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import Foundation
import OpenAPIClient

public protocol PrintheadInstructionSet {
    func toApiInstructions() -> PrintHeadInstructions
}
