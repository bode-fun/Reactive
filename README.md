# Reactive 💥

A small and very simple state management and reactive system written in Swift 🐦

Everything is about state 🤯

- The runtime holds the state and manages effects 🫡
- The Signal is an event emitter 📰
  - It sets and modifies its subscribers 🤔
  - It lets one access the state 📦
- Derivations compute values based upon the state 🧪
- Effects are closures which run whenever state changes 💥

## Example

### Counter

Run the following demo with `swift run ReactiveDemo`.
You can find the code [here](./Sources/ReactiveDemo/main.swift) 🥰

```swift
// Holding the state
// Signals need a global runtime which keeps their values
let runtime = Runtime()

// Creating the state
// Create the count signal
let count = runtime.createSignal(0)

// Changing the state
// Closures for changing the count
let increment = { count.setValue(count.getValue() + 1) }
let decrement = { count.setValue(count.getValue() - 1) }

// Computing based upon the state
// Derived values aka. computed values have to be closures.
// By being a closure, the evaluation of `double` gets
// delayed until the closure is executed.
let double = { count.getValue() * 2 }

// Reacting to state changes.
// This closure reruns whenever count.setValue() gets executed.
// It prints the current count and the double count into the console.
// Furthermore, to subscribe to changes, it gets executed 
// when runtime.createEffect is run initially.
runtime.createEffect {
  print(count.getValue())
  // Console: 0
  print(double())
  // Console: 0
}
// Attention: Don't try something like count.setValue(count.getValue() * 2) inside of effects!
// Setting the signal, which triggered the effect, in the same effect
// leads to an endless loop!

// Modifying the state.
increment()
// Console: 1
// Console: 2

increment()
// Console: 2
// Console: 4

decrement()
// Console: 1
// Console: 2

decrement()
// Console: 0
// Console: 0
```

## Matureness

This is an experiment. Swift has a great reactive system already build in! 😼

DO NOT USE THIS! 🙅
