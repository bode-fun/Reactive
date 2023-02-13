//
//  Signal.swift
//
//
//  Created by Jan Fooken on 07.02.23.
//

import XCTest

@testable import Reactive

final class EffectTests: XCTestCase {
    func testEffectCanReadSignalAndReruns() {
        let runtime = Runtime()

        let count = runtime.createSignal(1)
        var doubled = 0

        runtime.createEffect {
            doubled = count.getValue() * 2
        }

        XCTAssertEqual(doubled, 2)

        count.setValue(2)
        XCTAssertEqual(doubled, 4)
    }

    func testEffectCanSetSignal() {
        // Currently this test creates a Bad access
        // I have to debug this to find out what is going on
        let runtime = Runtime()

        let count = runtime.createSignal(1)
        let syncedSignal = runtime.createSignal(0)

        runtime.createEffect {
            // You should not set a signal inside of an effect!
            // This is what derivations are used for!
            // Nonetheless, I want to find out what happens 🤔

            // This sets the current effect as subscriber
            let currentCount = count.getValue()

            // this reruns the first effect!
            syncedSignal.setValue(currentCount)
        }

        count.setValue(2)
        XCTAssertEqual(count.getValue(), 2)
        XCTAssertEqual(syncedSignal.getValue(), 2)
    }

    func testEffectCanSetSignalWithOwnEffect() throws {
        throw XCTSkip("Needs further investigation")
        // Currently this test creates a Bad access
        // I have to debug this to find out what is going on
        let runtime = Runtime()

        let count = runtime.createSignal(1)
        let syncedSignal = runtime.createSignal(0)
        var syncedValue = 0

        runtime.createEffect {
            // This syncs the value to the signal and runs when the synced signal changes
            // It is the first effect that runs
            syncedValue = syncedSignal.getValue()
        }

        runtime.createEffect {
            // You should not set a signal inside of an effect!
            // This is what derivations are used for!
            // Nonetheless, I want to find out what happens 🤔

            // This sets the current effect as subscriber
            let currentCount = count.getValue()

            // this reruns the first effect!
            syncedSignal.setValue(currentCount)
        }

        count.setValue(2)
        XCTAssertEqual(count.getValue(), 2)
        XCTAssertEqual(syncedSignal.getValue(), 2)
        XCTAssertEqual(syncedValue, 2)
    }

    func testEffectCanGetSignalValueProperty() throws {
        throw XCTSkip("The value property needs further investigation")

        let runtime = Runtime()

        var count = runtime.createSignal(1)
        var synced = 0

        runtime.createEffect {
            synced = count.value
        }

        XCTAssertEqual(synced, 1)

        count.value = 2
        XCTAssertEqual(synced, 2)
    }

    func testEffectCanGetAndSetTheSameSignalValueProperty() throws {
        throw XCTSkip("The value property needs further investigation")

        let runtime = Runtime()

        var count = runtime.createSignal(1)

        runtime.createEffect {
            count.value += 1
        }

        XCTAssertEqual(count.value, 2)

        count.value = 3
        XCTAssertEqual(count.value, 4)
    }

    func testSimpleCounter() {
        let runtime = Runtime()

        let count = runtime.createSignal(0)

        var syncedCount = 0

        // Derived values
        let increment = { count.setValue(count.getValue() + 1) }
        let decrement = { count.setValue(count.getValue() - 1) }

        runtime.createEffect {
            syncedCount = count.getValue()
        }

        XCTAssertEqual(count.getValue(), 0)
        XCTAssertEqual(syncedCount, 0)

        increment()
        XCTAssertEqual(count.getValue(), 1)
        XCTAssertEqual(syncedCount, 1)

        increment()
        XCTAssertEqual(count.getValue(), 2)
        XCTAssertEqual(syncedCount, 2)

        decrement()
        XCTAssertEqual(count.getValue(), 1)
        XCTAssertEqual(syncedCount, 1)

        decrement()
        XCTAssertEqual(count.getValue(), 0)
        XCTAssertEqual(syncedCount, 0)
    }
}
