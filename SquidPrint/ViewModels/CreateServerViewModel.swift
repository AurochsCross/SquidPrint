//
//  CreateServerViewModel.swift
//  SquidPrint
//
//  Created by Petras Malinauskas on 2020-11-22.
//

import Foundation
import Combine
import SquidPrintLogic

class CreateServerViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var address: String = ""
    @Published var port: String = ""
    @Published var apiKey: String = ""
    
    private let onSaveSubject: PassthroughSubject<ServerSettings, Never>
    
    init(onSave: PassthroughSubject<ServerSettings, Never>) {
        onSaveSubject = onSave
    }
    
    func onSave() {
        onSaveSubject.send(ServerSettings(name: name, address: address, port: port, apiKey: apiKey))
    }
}
