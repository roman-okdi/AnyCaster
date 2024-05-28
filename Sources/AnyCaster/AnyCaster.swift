//
//  AnyCaster.swift
//
//
//  Created by Roman Imanaliev on 28.05.2024.
//

import Foundation

/// AnyCaster is a utility class designed to perform type casting on a wrapped value of type Any.
public struct AnyCaster {
    
    /// The value to be cast.
    public let value: Any
    
    /// Initializes an AnyCaster with the given value.
    /// - Parameter value: The value to be cast.
    public init(_ value: Any) {
        self.value = value
    }
    
    /// Casts the wrapped value to the specified type.
    /// - Parameter type: The type to cast the value to.
    /// - Throws: `AnyCasterError.failedCast` if the cast fails.
    /// - Returns: The value cast to the specified type.
    public func cast<T>(to type: T.Type = T.self) throws -> T {
        guard let result = value as? T else {
            throw AnyCasterError.failedCast
        }
        return result
    }
    
    /// Casts the wrapped value to the specified type and maps it using the provided closure.
    /// - Parameters:
    ///   - type: The type to cast the value to.
    ///   - map: A closure that takes the cast value and returns a mapped value.
    /// - Throws: `AnyCasterError.failedCast` if the cast fails, or an error thrown by the mapping closure.
    /// - Returns: The mapped value.
    public func cast<T, R>(to type: T.Type = T.self, map: @escaping (_ value: T) throws -> R) throws -> R {
        guard let temp = value as? T else {
            throw AnyCasterError.failedCast
        }
        return try map(temp)
    }
    
    /// Casts the wrapped value to the specified type and maps it using the provided closure, throwing an error if the closure returns nil.
    /// - Parameters:
    ///   - type: The type to cast the value to.
    ///   - map: A closure that takes the cast value and returns an optional mapped value.
    /// - Throws: `AnyCasterError.failedCast` if the cast fails, `AnyCasterError.skipOptional` if the closure returns nil, or an error thrown by the mapping closure.
    /// - Returns: The non-optional mapped value.
    public func cast<T, R>(to type: T.Type = T.self, map: @escaping (_ value: T) throws -> R?) throws -> R {
        guard let temp = value as? T else {
            throw AnyCasterError.failedCast
        }
        guard let result = try map(temp) else {
            throw AnyCasterError.skipOptional
        }
        return result
    }
    
    /// Casts the wrapped value to the specified type and maps it using the provided closure, allowing the closure to return nil.
    /// - Parameters:
    ///   - type: The type to cast the value to.
    ///   - mapWithOptional: A closure that takes the cast value and returns an optional mapped value.
    /// - Throws: `AnyCasterError.failedCast` if the cast fails, or an error thrown by the mapping closure.
    /// - Returns: The optional mapped value.
    public func cast<T, R>(to type: T.Type = T.self, mapWithOptional: @escaping (_ value: T) throws -> R?) throws -> R? {
        guard let temp = value as? T else {
            throw AnyCasterError.failedCast
        }
        return try mapWithOptional(temp)
    }
}
