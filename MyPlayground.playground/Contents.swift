import UIKit
import Combine

var cancellables = Set<AnyCancellable>()

protocol Foo {
    var name: AnyPublisher<String, Error> { get }
}

class Bar: Foo {
    var name: AnyPublisher<String, Error> { Just<String>("Bar").setFailureType(to: Error.self).eraseToAnyPublisher() }
}

Just<Void>(())
    .flatMap { _ -> AnyPublisher<Foo, Error> in
        return Just<Foo>(Bar()).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    .flatMap { foo in
        return foo.name
    }
    .sink(receiveCompletion: { _ in } , receiveValue: { name in
        print(name)
    })
    .store(in: &cancellables)
