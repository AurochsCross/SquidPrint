//
//  ApiConfigurator.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation

class ApiManager {
    private var currentConfiguration: ApiConfiguration
    
    init(configuration: ApiConfiguration) {
        self.currentConfiguration = .empty
        configure(withSettings: configuration)
    }
    
    func configure(withSettings settings: ApiConfiguration) {
        self.currentConfiguration = settings
        ApiConfigurationUtility.configureApi(settings)
    }
}
