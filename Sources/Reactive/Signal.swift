//
//  Signal.swift
//
//
//  Created by Jan Fooken on 06.02.23.
//

typealias SignalId = Int

public struct Signal<T> {
    let runtime: Runtime
    let id: SignalId

    // TODO: The value property is not working
    internal var value: T {
        get {
            getValue()
        }

        set {
            setValue(newValue)
        }
    }

    public func getValue() -> T {
        let downCastedValue = getSignalValue()

        addSignalSubscribers()

        return downCastedValue
    }

    public func setValue(_ newValue: T) {
        updateSignalValue(value: newValue, id: id)

        notifySignalSubscribers()
    }

    private func getSignalValue() -> T {
        let runtimeValue = runtime.signalValues[id]
        let downCastedValue = runtimeValue as! T
        return downCastedValue
    }

    private func updateSignalValue(value: T, id: SignalId) {
        runtime.signalValues[id] = value
    }

    private func addSignalSubscribers() {
        if let runningEffect = runtime.runningEffect {
            var subscribers = runtime.signalSubscribers[id] ?? Set()
            // TODO: Error: BAD ACCESS CODE 2 because of multithreading??
            subscribers.insert(runningEffect)
            runtime.signalSubscribers[runningEffect] = subscribers
        }
    }

    private func notifySignalSubscribers() {
        // TODO: Figure out if this has to be cloned?
        if let subscribers = runtime.signalSubscribers[id] {
            // TODO: Error: BAD ACCESS CODE 2 because of multithreading??
            let clonedSubscribers = Set<EffectId>(subscribers)
            for subscriber in clonedSubscribers {
                // TODO: This gets the value before the current set value property is executed...
                // Therefore, getting the value property in an effect fails.
                // TODO: Use some kind of mutex?
                runtime.runEffect(subscriber)
            }
        }
    }
}
