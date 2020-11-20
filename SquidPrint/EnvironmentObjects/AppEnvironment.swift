//
//  AppEnvironment.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import Combine

class AppEnvironment: ObservableObject {
    let apiManager = ApiManager(configuration: ApiConfiguration.empty)
}
