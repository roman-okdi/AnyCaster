//
//  AnyDictionaryCaster.swift
//
//
//  Created by Roman Imanaliev on 28.05.2024.
//

public struct AnyDictionaryCaster {
    
    public let value: [AnyHashable: AnyCaster]
    
    public init(_ value: [AnyHashable : AnyCaster]) {
        self.value = value
    }
    
    public init(_ value: Any) throws {
        guard let dict = value as? [AnyHashable: Any] else {
            throw AnyCasterError.failedCast
        }
        self.value = dict.mapValues(AnyCaster.init)
    }
    
    public func get(_ key: AnyHashable) throws -> AnyCaster {
        guard let result = value[key] else {
            throw AnyCasterError.missingValue
        }
        return result
    }
    
    public subscript(key: AnyHashable) -> AnyCaster? {
        value[key]
    }
}
