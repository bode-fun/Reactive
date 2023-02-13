import JavaScriptKit
import Reactive

// Has to be in the global scope
let document: JSValue = JSObject.global.document
let runtime = Runtime()

func counterComponent() -> JSValue {
    // State
    let count = runtime.createSignal(0)

    // Mutations
    let increment = { count.setValue(count.getValue() + 1) }
    let decrement = { count.setValue(count.getValue() - 1) }

    // Elements
    var counterParagraphElement = document.createElement("p")
    runtime.createEffect {
        counterParagraphElement.innerText = .string(JSString("Count: \(count.getValue())"))
    }

    var incrementButtonElement = document.createElement("button")
    incrementButtonElement.innerText = "Increment"
    incrementButtonElement.onclick = .object(JSClosure { _ in
        increment()
        return .undefined
    })

    var decrementButtonElement = document.createElement("button")
    decrementButtonElement.innerText = "Decrement"
    decrementButtonElement.onclick = .object(JSClosure { _ in
        decrement()
        return .undefined
    })

    let divElement = document.createElement("div")
    _ = divElement.appendChild(incrementButtonElement)
    _ = divElement.appendChild(counterParagraphElement)
    _ = divElement.appendChild(decrementButtonElement)

    return divElement
}

_ = document.body.appendChild(counterComponent())
