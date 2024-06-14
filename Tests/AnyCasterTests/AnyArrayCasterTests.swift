//
//  AnyArrayCasterTests.swift
//  
//
//  Created by Roman Imanaliev on 14.06.2024.
//

import XCTest
import Nimble
@testable import AnyCaster

class AnyArrayCasterTests: XCTestCase {

    func testInitializationWithArray() {
        let array: [Any] = [1, "value"]
        let caster = AnyArrayCaster(array.map(AnyCaster.init))
        expect(caster.value[0].value as? Int) == 1
        expect(caster.value[1].value as? String) == "value"
    }
    
    func testInitializationWithValidAny() {
        let array: [Any] = [1, "value"]
        expect { try AnyArrayCaster(array) }.notTo(throwError())
    }
    
    func testInitializationWithInvalidAny() {
        let invalidValue: Any = "invalid"
        expect { try AnyArrayCaster(invalidValue) }.to(throwError(AnyCasterError.failedCast))
    }
    
    func testRetrievingValues() throws {
        let array: [Any] = [1, "value"]
        let caster = try AnyArrayCaster(array)
        let value1 = try caster.get(0).cast(to: Int.self)
        let value2 = try caster.get(1).cast(to: String.self)
        expect(value1) == 1
        expect(value2) == "value"
    }
    
    func testRetrievingValueForInvalidIndex() throws {
        let array: [Any] = [1, "value"]
        let caster = try AnyArrayCaster(array)
        expect { try caster.get(2) }.to(throwError(AnyCasterError.missingValue))
    }
    
    func testSubscriptRetrievingValues() throws {
        let array: [Any] = [1, "value"]
        let caster = try AnyArrayCaster(array)
        expect(caster[0]?.value as? Int) == 1
        expect(caster[1]?.value as? String) == "value"
        expect(caster[2]).to(beNil())
    }
}
