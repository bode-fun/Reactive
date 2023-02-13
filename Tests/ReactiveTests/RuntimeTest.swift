//
//  RuntimeTest.swift
//
//
//  Created by Jan Fooken on 06.02.23.
//

import XCTest

@testable import Reactive

final class RuntimeTest: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testACreatedSignalGetsPushedIntoTheRuntime() throws {
        let runtime = Runtime()
        XCTAssertEqual(runtime.signalValues.count, 0)

        _ = runtime.createSignal(0)
        XCTAssertEqual(runtime.signalValues.count, 1)
    }

    func testGlobalRuntimeSynchronizedWithSignalsReference() throws {
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
