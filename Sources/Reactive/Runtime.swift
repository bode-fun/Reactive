//
//  Runtime.swift
//
//
//  Created by Jan Fooken on 06.02.23.
//

public class Runtime {
    var signalValues: [Any] = []
    var runningEffect: EffectId?
    var signalSubscribers: [SignalId: Set<EffectId>] = [:]
    var effects: [() -> Void] = []

    public init() {}

    public func createSignal<T>(_ value: T) -> Signal<T> {
        // Append value to values
        signalValues.append(value)
        // Get id of current value
        let id = signalValues.count - 1
        // Return signal with type information and reference id of the tracked value
        // Runtime has to be a class because it has to be passed by reference,
        // which is not possible with structs
        return Signal<T>(runtime: self, id: id)
    }

    public func createEffect(_ callback: @escaping () -> Void) {
        effects.append(callback)
        let id = effects.count - 1
        // Run the effect so the signal can ad it to their subscribers
        runEffect(id)
    }

    internal func runEffect(_ id: EffectId) {
        // Push the new effect to the "stack"
        let previousRunningEffect = runningEffect
        runningEffect = id
        let effect = effects[id]
        effect()
        // After the effect ran, pop the current effect from the "stack"
        runningEffect = previousRunningEffect

        // TODO: Do I have to clean up the subscribers after the effect ran?
    }
}
