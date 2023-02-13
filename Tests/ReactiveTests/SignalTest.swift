//
//  SignalTest.swift
//
//
//  Created by Jan Fooken on 06.02.23.
//

import XCTest

@testable import Reactive

final class SignalTest: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTheCompilerPreservesTheSignalType() throws {
        let runtime = Runtime()
        let count = runtime.createSignal(0)

        XCTAssert(type(of: count) == Signal<Int>.self)
    }

    func testSignalUpdateItsValue() throws {
        let runtime = Runtime()
        var count = runtime.createSignal(0)
        count.value = 2

        XCTAssertEqual(count.value, 2)
    }

    func testNewSignalIsEqualToItsInitialRuntimeValue() throws {
        let runtime = Runtime()
        let count = runtime.createSignal(2)

        XCTAssertEqual(count.value, 2)
    }

    func testSignalChangeUpdatesItsRuntimeValue() throws {
        let runtime = Runtime()
        var count = runtime.createSignal(0)
        count.value = 2

        let runtimeValue = runtime.signalValues[count.id] as! Int
        XCTAssertEqual(runtimeValue, 2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
