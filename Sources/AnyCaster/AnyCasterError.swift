//
//  AnyCasterError.swift
//
//
//  Created by Roman Imanaliev on 28.05.2024.
//

/// An error type that represents the possible errors that can occur during casting in AnyCaster.
public enum AnyCasterError: Error {
    case failedCast
    case skipOptional
}
