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
        self.name = name
        self.address = address
        self.port = port
        self.apiKey = apiKey
    }
    
    init(managed: DB_ServerSettings) {
        name = "No name"
        address = managed.address ?? ""
        port = managed.port
        apiKey = managed.apiKey ?? ""
    }
    
    func updateManaged(_ managed: DB_ServerSettings?, context: NSManagedObjectContext) -> DB_ServerSettings {
        let existingManaged = managed ?? DB_ServerSettings(context: context)
        
        existingManaged.name = name
        existingManaged.apiKey = apiKey
        existingManaged.address = address
        existingManaged.port = port
        
        return existingManaged
    }
}
