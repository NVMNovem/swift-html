# SwiftHTML Architecture

## Public typed DSL

The public API consists of ordinary capitalized Swift structs such as:

- `HTML`
- `Body`
- `H1`
- `Div`
- `Template`

For example:

```swift
HTML {
    Body {
        H1 {
            "Hello"
        }
        P {
            "Welcome to SwiftHTML."
        }
    }
}
```

These are concrete Swift types, not capitalized factory functions. Public elements conform to `HTMLNodeConvertible` and lower into the renderer model.

## Concrete HTML AST

The renderer model is the recursive `HTMLNode` enum AST.

- `HTMLBuilder` produces `[HTMLNode]`.
- No `[any HTMLNode]` storage is used.
- The AST distinguishes documents, elements, escaped text, and raw text.
- Builder strings become escaped `.text` nodes.
- `RawText` lowers to `.rawText`.

This design avoids:

- Existential storage
- Dynamic casting
- Reflection-based node discovery
- Runtime type erasure in renderer traversal

## Renderers

Renderers consume only `HTMLNode` and traverse it through exhaustive enum switches.

`HTMLStringRenderer` is responsible for:

- Doctype output
- Opening and closing tags
- Void element handling
- Attributes
- Escaping
- Raw text
- Indentation
- Pretty and compact formatting
- Recursive traversal

`HTMLTreeDumpRenderer` provides a stable debug representation of the same AST.

A future `DOMRenderer` can consume the same AST without changing the public DSL.

## Embedded Swift compatibility

The enum AST was chosen deliberately for Embedded Swift. Its renderer path uses:

- No `[any HTMLNode]`
- No existential renderer traversal
- No dynamic casts in renderers
- No reflection-dependent node discovery
- No `@unchecked Sendable`

The architecture was validated with:

```sh
swift build --swift-sdk swift-6.3.3-RELEASE_wasm-embedded
```

This build passed successfully.

## Architectural boundary

SwiftHTML owns:

- HTML elements
- Attributes
- The concrete HTML AST
- Escaping
- HTML-specific renderers

Higher-level packages may lower their own view models into `HTMLNode`, but should not duplicate HTML elements, escaping, or traversal logic.

```text
Public SwiftHTML DSL
        ↓
Concrete HTMLNode AST
        ↓
HTMLStringRenderer
HTMLTreeDumpRenderer
Future DOMRenderer
```
