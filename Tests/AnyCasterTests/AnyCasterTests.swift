//
//  AnyCasterTests.swift
//
//
//  Created by Roman Imanaliev on 28.05.2024.
//

import XCTest
import Nimble
@testable import AnyCaster

class AnyCasterTests: XCTestCase {
    
    func testCastSuccess() throws {
        let value = "123"
        let caster = AnyCaster(value as Any)
        expect({ try caster.cast(to: String.self) }) == value
    }
    
    func testCastFailure() {
        let value = "123"
        let caster = AnyCaster(value as Any)
        expect({ try caster.cast(to: Int.self) })
            .to(throwError(AnyCasterError.failedCast))
    }
    
    func testCastWithMappingSuccess() throws {
        let value = 123
        let expectedResult = String(value)
        let caster = AnyCaster(value as Any)
        expect({
            try caster.cast(to: Int.self, map: { String($0) })
        }) == expectedResult
    }
    
    func testCastMappingAndOptionalReturnFailure() {
        let value = 123
        let caster = AnyCaster(value as Any)
        expect({
            try caster.cast(to: String.self, map: Int.init)
        }).to(throwError(AnyCasterError.failedCast))
    }
    
    func testCastWithMappingFailure() {
        let value = "123"
        let caster = AnyCaster(value as Any)
        expect({
            try caster.cast(to: Int.self, map: { String($0) })
        }).to(throwError(AnyCasterError.failedCast))
    }
    
    func testCastWithOptionalMappingSuccess() {
        let expectedResult = 123
        let value = String(expectedResult)
        let caster = AnyCaster(value as Any)
        expect({
            try caster.cast(to: String.self, map: Int.init)
        }) == expectedResult
    }
    
    func testCastWithOptionalMappingNilResult() {
        let value = "abc"
        let caster = AnyCaster(value as Any)
        expect({
            try caster.cast(to: String.self, map: Int.init)
        }).to(throwError(AnyCasterError.skipOptional))
    }
    
    func testCastWithOptionalMappingAndOptionalReturnSuccess() {
        let expectedResult = 123
        let value = String(expectedResult)
        let caster = AnyCaster(value as Any)
        expect({
            try caster.cast(to: String.self, mapWithOptional: Int.init)
        }) == expectedResult
    }
    
    func testCastWithOptionalMappingAndOptionalReturnNilResult() {
        let value = "abc"
        let caster = AnyCaster(value as Any)
        expect({
            try caster.cast(to: String.self, mapWithOptional: Int.init)
        }).to(beNil())
    }
    
    func testCastWithOptionalMappingAndOptionalReturnFailure() {
        let value = 123
        let caster = AnyCaster(value as Any)
        expect({
            try caster.cast(to: String.self, mapWithOptional: Int.init)
        }).to(throwError(AnyCasterError.failedCast))
    }
}
