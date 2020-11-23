//
//  ServerSettings.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-20.
//

import Foundation
import CoreData

public struct ServerSettings: Identifiable {
    public var id: Int {
        ((name ?? "") + (apiKey)).hash
    }
    
    public var name: String? = nil
    public var address: String = ""
    public var port: String? = nil
    public var apiKey: String = ""
    
    public init() { }
    
    public init(name: String? = nil, address: String, port: String? = nil, apiKey: String) {
        self.name = name?.isEmpty ?? true ? nil : name
        self.address = address
        self.port = port?.isEmpty ?? true ? nil : port
        self.apiKey = apiKey
    }
    
    init(managed: DB_ServerSettings) {
        name = managed.name
        address = managed.address ?? ""
        port = managed.port
        apiKey = managed.apiKey ?? ""
    }
    
    func updateManaged(_ managed: DB_ServerSettings) -> DB_ServerSettings {
        managed.name = name
        managed.apiKey = apiKey
        managed.address = address
        managed.port = port
        
        return managed
    }
    
    func updateManaged(_ managed: DB_ServerSettings?, context: NSManagedObjectContext) -> DB_ServerSettings {
        let existingManaged = managed ?? DB_ServerSettings(context: context)
        return updateManaged(existingManaged)
    }
}

extension ServerSettings {
    public var fullAddress: String {
        "\(address)\(port != nil ? ":\(port!)" : "")"
    }
    
    public var displayName: String {
        name ?? fullAddress
    }
}
