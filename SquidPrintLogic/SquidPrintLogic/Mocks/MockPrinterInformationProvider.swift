//
//  MockPrinterInformationProvider.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-26.
//

import Foundation
import Combine
import OpenAPIClient

class MockPrinterInformationProvider: PrinterInformationProvider {
    var temperatureProvider: PrinterTemperatureProvider = MockPrinterTemperatureProvider()
    
    var printerState = CurrentValueSubject<FullState?, Never>(
        FullState(
            temperature: TemperatureState(
                tool0: Temperature(
                    actual: 108,
                    target: 205,
                    offset: 0)),
            sd: SdState(
                ready: true),
            state: PrinterState(
                text: "Printing",
                flags: PrinterStateFlags(
                    operational: true,
                    paused: false,
                    printing: true,
                    cancelling: false,
                    pausing: false,
                    sdReady: true,
                    error: false,
                    ready: false,
                    closedOrError: false)))
    )
    
    
}
