//
//  PublisherUtilities.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-21.
//

import Foundation
import Combine

class PublisherUtilities {
    static func either<T>(value: T?, orPublisher publisher: AnyPublisher<T, Error>) -> AnyPublisher<T, Error> {
        if let value = value {
            return Just<T>(value).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        
        return publisher
    }
    
    static func anyWithValue<T>(_ value: T) -> AnyPublisher<T, Error> {
        Just<T>(value).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
