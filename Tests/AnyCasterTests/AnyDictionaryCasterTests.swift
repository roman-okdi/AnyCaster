//
//  AnyDictionaryCasterTests.swift
//  
//
//  Created by Roman Imanaliev on 28.05.2024.
//

import XCTest
import Nimble
@testable import AnyCaster

final class AnyDictionaryCasterTests: XCTestCase {

    func testInitializationWithDictionary() {
        let dict: [AnyHashable: Any] = ["key1": 1, "key2": "value"]
        let caster = AnyDictionaryCaster(dict.mapValues(AnyCaster.init))
        expect(caster.value["key1"]?.value as? Int) == 1
        expect(caster.value["key2"]?.value as? String) == "value"
    }
    
    func testInitializationWithValidAny() {
        let dict: [AnyHashable: Any] = ["key1": 1, "key2": "value"]
        expect { try AnyDictionaryCaster(dict) }.notTo(throwError())
    }
    
    func testInitializationWithInvalidAny() {
        let invalidValue: Any = "invalid"
        expect { try AnyDictionaryCaster(invalidValue) }.to(throwError(AnyCasterError.failedCast))
    }
    
    func testRetrievingValues() {
        let dict: [AnyHashable: Any] = ["key1": 1, "key2": "value"]
        let caster = try! AnyDictionaryCaster(dict)
        let value1 = try! caster.get("key1").cast(to: Int.self)
        let value2 = try! caster.get("key2").cast(to: String.self)
        expect(value1) == 1
        expect(value2) == "value"
    }
    
    func testRetrievingValueForMissingKey() {
        let dict: [AnyHashable: Any] = ["key1": 1, "key2": "value"]
        let caster = try! AnyDictionaryCaster(dict)
        expect { try caster.get("missingKey") }.to(throwError(AnyCasterError.missingValue))
    }
    
    func testSubscriptRetrievingValues() {
        let dict: [AnyHashable: Any] = ["key1": 1, "key2": "value"]
        let caster = try! AnyDictionaryCaster(dict)
        expect(caster["key1"]?.value as? Int) == 1
        expect(caster["key2"]?.value as? String) == "value"
        expect(caster["missingKey"]).to(beNil())
    }
}
