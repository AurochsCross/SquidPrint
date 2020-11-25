//
//  Api+ServerSelection.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-24.
//

import Foundation
import OpenAPIClient

extension OpenAPIClientAPI {
    static func setSettings(forServer settings: ServerSettings) {
        self.basePath = settings.fullAddress + "/api"
        self.customHeaders["X-Api-Key"] = settings.apiKey
    }
}
