//
//  Signal.swift
//
//
//  Created by Jan Fooken on 06.02.23.
//

typealias SignalId = Int

struct Signal<T> {
  let runtime: Runtime
  let id: SignalId

  var value: T {
    get {
      // Get value
      let runtimeValue = self.runtime.signalValues[self.id]
      let downCastedValue = runtimeValue as! T

      // Add subscribers

      // Return value
      return downCastedValue
    }

    mutating set {
      self.runtime.signalValues[self.id] = newValue
    }
  }
}
