//
//  Runtime.swift
//
//
//  Created by Jan Fooken on 06.02.23.
//

class Runtime {
  var signalValues: [Any] = []

  public func createSignal<T>(value: T) -> Signal<T> {
    // Append value to values
    signalValues.append(value)
    // Get id of current value
    let id = signalValues.count - 1
    // Return signal with type informations and reference id of the tracked value
    // Runtime has to be a class because it has to be passed by reference,
    // which is not possible with structs
    return Signal<T>(runtime: self, id: id)
  }
}
