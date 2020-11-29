//
//  PrinterInformationProvider.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine
import OpenAPIClient

public protocol PrinterInformationProvider {
    var printerState: CurrentValueSubject<FullState?, Never> { get }
    var temperatureProvider: PrinterTemperatureProvider { get }
}
