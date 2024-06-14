//
//  AnyArrayCaster.swift
//
//
//  Created by Roman Imanaliev on 14.06.2024.
//

/// AnyArrayCaster is a utility struct designed to perform type casting on an array of wrapped values.
public struct AnyArrayCaster {
    
    /// The array containing wrapped values to be cast.
    public let value: [AnyCaster]
    
    /// Initializes an AnyArrayCaster with the given array.
    /// - Parameter value: The array containing wrapped values to be cast.
    public init(_ value: [AnyCaster]) {
        self.value = value
    }
    
    /// Initializes an AnyArrayCaster with the given value.
    /// - Parameter value: The value to be cast to an array.
    /// - Throws: `AnyCasterError.failedCast` if the cast to array fails.
    public init(_ value: Any) throws {
        guard let array = value as? [Any] else {
            throw AnyCasterError.failedCast
        }
        self.value = array.map(AnyCaster.init)
    }
    
    /// Retrieves the wrapped value at the given index.
    /// - Parameter index: The index for which to retrieve the wrapped value.
    /// - Throws: `AnyCasterError.missingValue` if the index is out of bounds.
    /// - Returns: The wrapped value at the given index.
    public func get(_ index: Int) throws -> AnyCaster {
        guard index >= 0 && index < value.count else {
            throw AnyCasterError.missingValue
        }
        return value[index]
    }
    
    /// Subscript for accessing wrapped values in the array.
    /// - Parameter index: The index for which to retrieve the wrapped value.
    /// - Returns: The wrapped value at the given index, or nil if the index is out of bounds.
    public subscript(index: Int) -> AnyCaster? {
        guard index >= 0 && index < value.count else {
            return nil
        }
        return value[index]
    }
}
