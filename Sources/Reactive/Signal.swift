//
//  Signal.swift
//
//
//  Created by Jan Fooken on 06.02.23.
//

struct Signal<T> {
  var runtime: Runtime
  let id: Int

  init(runtime: Runtime, id: Int) {
    self.runtime = runtime
    self.id = id
  }

  var value: T {
    get {
      let runtimeValue = self.runtime.signalValues[self.id]
      let downcastetValue = runtimeValue as! T
      return downcastetValue
    }

    mutating set {
      self.runtime.signalValues[self.id] = newValue
    }
  }
}
