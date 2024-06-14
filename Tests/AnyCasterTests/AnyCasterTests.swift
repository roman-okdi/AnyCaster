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
    
    func testToDictionaryCaster() {
        let dict: [AnyHashable: Any] = ["key1": 1, "key2": "value"]
        let caster = AnyCaster(dict)
        let dictCaster = try! caster.toDictionary()
        expect(dictCaster.value["key1"]?.value as? Int) == 1
        expect(dictCaster.value["key2"]?.value as? String) == "value"
    }
    
    func testToDictionaryCasterInvalid() {
        let caster = AnyCaster("not a dictionary")
        expect { try caster.toDictionary() }
            .to(throwError(AnyCasterError.failedCast))
    }
    
    func testToArrayCaster() {
        let array: [Any] = [1, "value"]
        let caster = AnyCaster(array)
        let arrayCaster = try! caster.toArray()
        expect(arrayCaster.value[0].value as? Int) == 1
        expect(arrayCaster.value[1].value as? String) == "value"
    }
    
    func testToArrayCasterInvalid() {
        let caster = AnyCaster("not an array")
        expect { try caster.toArray() }
            .to(throwError(AnyCasterError.failedCast))
    }
    
    func testExample() throws {
        let data: Any = [
            "string": "some string",
            "int": 1,
            "array": [0, 1, 2, "3"],
            "dict": [
                1: 1
            ]
        ]
        let caster = try AnyDictionaryCaster(data)
        expect({
            try caster.get("dict")
                .toDictionary()
                .get(1)
                .cast(to: Int.self)
        }) == 1
        
        expect({
            try caster.get("array")
                .toArray()
                .get(3)
                .cast(to: String.self)
        }) == "3"
        
        expect({ try caster.get("int").cast(to: Int.self) }) == 1
    }
}
