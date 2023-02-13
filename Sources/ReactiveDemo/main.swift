import Reactive

// Holding the state
// Signals need a global runtime which keeps their values
let runtime = Runtime()

// Creating the state
// Create the count signal
let count = runtime.createSignal(0)

// Changing the state
// Closures for changing the count
func increment() {
    print("Incrementing Counter")
    count.setValue(count.getValue() + 1)
}

func decrement() {
    print("Decrementing Counter")
    count.setValue(count.getValue() - 1)
}

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
var effectCompletedInitialRun = false
runtime.createEffect {
    if effectCompletedInitialRun {
        print("Dependencies changed")
    } else {
        print("Registering signals")
    }

    print("Effect gets executed")
    print("Count: \(count.getValue())")
    // Console: 0
    print("Double: \(double())")
    print()
    // Console: 0

    effectCompletedInitialRun = true
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
