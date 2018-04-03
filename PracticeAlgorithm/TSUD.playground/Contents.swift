//: Playground - noun: a place where people can play
import Foundation

protocol TSUD {
    associatedtype ValueType: Codable
    
    init()
    
    static var defaultValue: ValueType { get }
    static var stringKey: String { get }
}

extension TSUD {
    static var stringKey: String {
        let s = String(describing: Self.self)
        if let index = s.index(of: " ") {
            return String(s[..<index])
        } else {
            return s
        }
    }
}

extension TSUD {
    public subscript(nsud: UserDefaults) -> ValueType {
        get {
            return decode(nsud.object(forKey: Self.stringKey)) ?? Self.defaultValue
        }
        nonmutating set {
            nsud.set(encode(newValue), forKey: Self.stringKey)
        }
    }
    
    public static func get(_ nsud: UserDefaults = .standard) -> ValueType {
        return self.init()[nsud]
    }
    
    public static func set(_ value: ValueType, _ nsud: UserDefaults = .standard) {
        self.init()[nsud] = value
    }
    
    public static var value: ValueType {
        get {
            return get()
        }
        set {
            return set(newValue)
        }
    }
    
    private func encode(_ value: ValueType) -> Any? {
        switch value {
        case let value as Optional<Any> where value == nil:
            return nil
        case is Date,
             is Data:
            return value
        default:
            let data = try? PropertyListEncoder().encode([value])
            guard let dataUnwrapped = data else { return nil }
            let wrappedPlist = (try? PropertyListSerialization.propertyList(from: dataUnwrapped, options: [], format: nil)) as? [Any]
            return wrappedPlist?[0]
        }
    }
    
    private func decode(_ plist: Any?) -> ValueType? {
        guard let plist = plist else { return nil }
        switch ValueType.self {
        case is Date.Type,
             is Data.Type:
            return plist as? ValueType
        default:
            let data = try? PropertyListSerialization.data(fromPropertyList: plist, format: .binary, options: 0)
            guard let dataUnwrapped = data else { return nil }
            return try? PropertyListDecoder().decode(ValueType.self, from: dataUnwrapped)
        }
    }
}

struct FontSize: TSUD {
    static var defaultValue: Double? = 12.0
}

FontSize.value = 25.0
FontSize.value
FontSize.value = 26.0
FontSize.value = 27.0
//FontSize.value
//FontSize.value += 6.0
FontSize.value
FontSize.value = nil
FontSize.value
FontSize.stringKey

struct hasWidgets: TSUD {
    static let defaultValue = false
    static let stringKey = "Has Widgets"
}

hasWidgets.value = true
hasWidgets.stringKey
hasWidgets.value

struct Person: Codable {
    var name: String
    var quest: String
    var age: Int
}

struct testPerson: TSUD {
    static let defaultValue: Person? = nil
}

testPerson.value = Person(name: "An", quest: "Hello", age: 24)
testPerson.value?.name
testPerson.value?.name = "Van"
testPerson.value?.name


