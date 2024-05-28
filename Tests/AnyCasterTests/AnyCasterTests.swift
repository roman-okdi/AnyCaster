//
//  AnyCasterTests.swift
//
//
//  Created by Roman Imanaliev on 28.05.2024.
//

import XCTest
@testable import AnyCaster

class AnyCasterTests: XCTestCase {
    
    func testCastSuccess() {
        let anyValue: Any = "123"
        let caster = AnyCaster(value: anyValue)
        
        do {
            let stringValue: String = try caster.cast()
            XCTAssertEqual(stringValue, "123")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testCastFailure() {
        let anyValue: Any = 123
        let caster = AnyCaster(value: anyValue)
        
        XCTAssertThrowsError(try caster.cast(to: String.self)) { error in
            XCTAssertEqual(error as? AnyCasterError, AnyCasterError.failedCast)
        }
    }
    
    func testCastWithMappingSuccess() throws {
        let anyValue: Any = "123"
        let caster = AnyCaster(value: anyValue)
        
        let intValue: Int = try caster.cast(map: { str in
            if let int = Int(str) {
                return int
            }
            throw AnyCasterError.failedCast
        })
        XCTAssertEqual(intValue, 123)
    }
    
    func testCastWithMappingFailure() {
        let anyValue: Any = "abc"
        let caster = AnyCaster(value: anyValue)
        
        XCTAssertThrowsError(try caster.cast(to: String.self, map: Int.init)) { error in
            XCTAssertEqual(error as? AnyCasterError, AnyCasterError.failedCast)
        }
    }
    
    func testCastWithOptionalMappingSuccess() {
        let anyValue: Any = "123"
        let caster = AnyCaster(value: anyValue)
        
        do {
            let intValue: Int = try caster.cast(to: String.self, map: { str in
                return Int(str)
            })
            XCTAssertEqual(intValue, 123)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testCastWithOptionalMappingNilResult() {
        let anyValue: Any = "abc"
        let caster = AnyCaster(value: anyValue)
        
        XCTAssertThrowsError(try caster.cast(to: String.self, map: { str in
            return Int(str)
        })) { error in
            XCTAssertEqual(error as? AnyCasterError, AnyCasterError.skipOptional)
        }
    }
    
    func testCastWithOptionalMappingAndOptionalReturnSuccess() {
        let anyValue: Any = "123"
        let caster = AnyCaster(value: anyValue)
        
        do {
            let intValue: Int? = try caster.cast(mapWithOptional: { str in
                return Int(str)
            })
            XCTAssertEqual(intValue, 123)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testCastWithOptionalMappingAndOptionalReturnNilResult() {
        let anyValue: Any = "abc"
        let caster = AnyCaster(value: anyValue)
        
        do {
            let intValue: Int? = try caster.cast(mapWithOptional: { str in
                return Int(str)
            })
            XCTAssertNil(intValue)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testCastWithOptionalMappingAndOptionalReturnFailure() {
        let anyValue: Any = 123
        let caster = AnyCaster(value: anyValue)
        
        XCTAssertThrowsError(try caster.cast(mapWithOptional: { str in
            return Int("\(str)")
        })) { error in
            XCTAssertEqual(error as? AnyCasterError, AnyCasterError.failedCast)
        }
    }
}
