//
//  Logger.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import XCGLogger

let log: XCGLogger = {
    // Create a logger object with no destinations
    let log = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: false)

    // Create a destination for the system console log (via NSLog)
    let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.systemDestination")

    // Optionally set some configuration options
    systemDestination.outputLevel = .debug
    systemDestination.showLogIdentifier = false
    systemDestination.showFunctionName = true
    systemDestination.showThreadName = true
    systemDestination.showLevel = true
    systemDestination.showFileName = true
    systemDestination.showLineNumber = true
    systemDestination.showDate = true

    // Add the destination to the logger
    log.add(destination: systemDestination)

    // Add basic app info, version info etc, to the start of the logs
    log.logAppDetails()
    return log
}()
