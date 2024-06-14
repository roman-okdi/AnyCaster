//
//  AnyDictionaryCaster.swift
//
//
//  Created by Roman Imanaliev on 28.05.2024.
//

/// AnyDictionaryCaster is a utility struct designed to perform type casting on a dictionary of wrapped values.
public struct AnyDictionaryCaster {
    
    /// The dictionary containing wrapped values to be cast.
    public let value: [AnyHashable: AnyCaster]
    
    /// Initializes an AnyDictionaryCaster with the given dictionary.
    /// - Parameter value: The dictionary containing wrapped values to be cast.
    public init(_ value: [AnyHashable : AnyCaster]) {
        self.value = value
    }
    
    /// Initializes an AnyDictionaryCaster with the given value.
    /// - Parameter value: The value to be cast to a dictionary.
    /// - Throws: `AnyCasterError.failedCast` if the cast to dictionary fails.
    public init(_ value: Any) throws {
        guard let dict = value as? [AnyHashable: Any] else {
            throw AnyCasterError.failedCast
        }
        self.value = dict.mapValues(AnyCaster.init)
    }
    
    /// Retrieves the wrapped value for the given key.
    /// - Parameter key: The key for which to retrieve the wrapped value.
    /// - Throws: `AnyCasterError.missingValue` if the key is not found in the dictionary.
    /// - Returns: The wrapped value for the given key.
    public func get(_ key: AnyHashable) throws -> AnyCaster {
        guard let result = value[key] else {
            throw AnyCasterError.missingValue
        }
        return result
    }
    
    /// Subscript for accessing wrapped values in the dictionary.
    /// - Parameter key: The key for which to retrieve the wrapped value.
    /// - Returns: The wrapped value for the given key, or nil if the key is not found.
    public subscript(key: AnyHashable) -> AnyCaster? {
        value[key]
    }
}
