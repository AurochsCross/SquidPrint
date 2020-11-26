//
//  ApiCallExecutor.swift
//  SquidPrintLogic
//
//  Created by Petras Malinauskas on 2020-11-25.
//

import Foundation
import Combine

protocol ApiCallExecutor {
    func execute<T>(_ call: AnyPublisher<T, Error>) -> AnyPublisher<T, Error>
}
