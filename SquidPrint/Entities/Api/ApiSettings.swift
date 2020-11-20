//
//  ApiSettings.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import SwiftKeychainWrapper

struct ApiSettings {
    private enum Keys {
        static let apiKey = "apiKey"
    }
    
    var localServer: ApiConfiguration?
    var externalServer: ApiConfiguration?
    
    var apiKey: String? {
        get {
            KeychainWrapper.standard.string(forKey: Keys.apiKey)
        }
        set {
            guard let value = newValue else {
                KeychainWrapper.standard.removeObject(forKey: Keys.apiKey)
                return
            }
            
            KeychainWrapper.standard.set(value, forKey: Keys.apiKey)
        }
    }
}
