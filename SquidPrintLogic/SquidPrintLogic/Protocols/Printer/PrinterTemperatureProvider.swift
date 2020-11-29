//
//  PrinterTemperatureProvider.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-28.
//

import Foundation
import Combine

public protocol PrinterTemperatureProvider {
    var frames: CurrentValueSubject<[TemperatureFrame], Never> { get }
    func retrieveHistory()
}
