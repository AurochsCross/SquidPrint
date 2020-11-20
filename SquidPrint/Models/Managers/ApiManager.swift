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
        self.currentConfiguration = configuration
        configure(withSettings: configuration)
    }
    
    func configure(withSettings settings: ApiConfiguration) {
        
    }
}
