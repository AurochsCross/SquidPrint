//
//  ApiConfiguration.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation

struct ApiConfiguration {
    let address: String
    let port: Int
    let basePath: String?
    
    var path: String { "\(address):\(port)\(basePath != nil ? "/\(basePath!)" : "" )" }
}

extension ApiConfiguration {
    static var empty: ApiConfiguration { ApiConfiguration(address: "", port: 0, basePath: nil) }
}
