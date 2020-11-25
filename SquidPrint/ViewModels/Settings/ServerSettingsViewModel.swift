//
//  CreateServerViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import SquidPrintLogic

class ServerSettingsViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var port: String = ""
    @Published var apiKey: String = ""
    
    private let onSaveSubject: PassthroughSubject<ServerSettings, Never>
    
    init(currentSettings: ServerSettings? = nil, onSave: PassthroughSubject<ServerSettings, Never>) {
        onSaveSubject = onSave
        
        if let settings = currentSettings {
            setValues(fromSettings: settings)
        }
    }
    
    func onSave() {
        onSaveSubject.send(ServerSettings(name: name, address: address, port: port, apiKey: apiKey))
    }
    
    private func setValues(fromSettings settings: ServerSettings) {
        name = settings.name ?? ""
        address = settings.address
        port = settings.port ?? ""
        apiKey = settings.apiKey
    }
}
