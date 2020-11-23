import UIKit

var str = "Hello, playground"


extension Error {
    var localizedDescription: String {
        
        if let error = self as? CustomError { return error.localizedDescription }
        if let error = self as? OtherError { return error.localizedDescription }
        
        return localizedDescription
    }
}

enum CustomError: Error {
    case foo
    case bar
    
    var localizedDescription: String {
        switch self {
        case .foo: return "Foo"
        case .bar: return "Bar"
        }
    }
}

enum OtherError: Error {
    case foo
    case bar
    
    var localizedDescription: String {
        switch self {
        case .foo: return "Other Foo"
        case .bar: return "Other Bar"
        }
    }
}

enum UnknownError: Error {
    case foo
    case bar
    
    var localizedDescription: String {
        switch self {
        case .foo: return "unkwnown Foo"
        case .bar: return "unknwon Bar"
        }
    }
}



func logError(_ error: Error) {
    print(error.localizedDescription)
}

logError(CustomError.foo)
logError(OtherError.foo)
logError(UnknownError.foo)
print("Finished")
