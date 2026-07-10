# Typed HTML Tree Spike

## Goal

Investigate whether SwiftHTML can model child nodes without `[any HTMLNode]`,
`any HTMLNode`, dynamic casts, `as?`, or `is`, while preserving result-builder
syntax close to:

```swift
HTML {
    Body {
        H1 {
            TextNode("Hello")
        }

        P {
            TextNode("Intro")
        }
    }
}
```

## Implemented Model

The spike is an isolated nested Swift package under `Spikes/TypedHTMLTree`.
It does not change the production SwiftHTML package.

The proof uses:

- `protocol HTMLNode: Sendable` with `static var kind: NodeKind` and
  `render(into:)`
- `Element<Tag, Content>` where `Content: HTMLNode`
- concrete tag marker types such as `HTMLTagName`, `BodyTagName`, `H1TagName`
- `TextNode`
- `EmptyNode`
- `TupleNode<each Child: HTMLNode>` backed by a parameter-pack tuple
- `OptionalNode<Content>`
- `EitherNode<First, Second>`
- `ArrayNode<Content>`
- `ForEach<Data, Content>` with a `@Sendable` content closure

Rendering is generic:

```swift
public extension HTMLNode {
    func render() -> String {
        var renderer = HTMLRenderer()
        render(into: &renderer)
        return renderer.output
    }
}
```

Traversal is done through the `HTMLNode.render(into:)` protocol requirement,
not by switching over `any HTMLNode` or dynamically casting node values.

The spike also makes `HTMLTag` and `HTMLRenderer` `Sendable`. No
`@unchecked Sendable` conformance is used.

An Embedded-friendly visitor variant was also tried. Each node delegates to a
concrete renderer method such as `renderText(_:)`, `renderElement(_:)`,
`renderTuple(_:)`, and `renderForEach(_:)`. Recursive child traversal now calls
`child.render(into: &renderer)` directly. In particular, `TupleNode` avoids a
generic recursive renderer helper inside pack expansion:

```swift
public mutating func renderTuple<each Child: HTMLNode>(
    _ node: TupleNode<repeat each Child>
) {
    repeat (each node.children).render(into: &self)
}
```

## 1. Can a result builder emit a typed tuple/pack instead of `[any HTMLNode]`?

Yes for static children.

The key overload is:

```swift
public static func buildBlock<each Content: HTMLNode>(
    _ content: repeat each Content
) -> TupleNode<repeat each Content>
```

This lets a builder block produce a concrete `TupleNode<H1<...>, P<...>>`
shape instead of `[any HTMLNode]`.

Zero children are represented by `EmptyNode`.

## 2. Can containers store typed content without existential erasure?

Yes.

`Element<Tag, Content>` stores:

```swift
let content: Content
```

The element does not store `[any HTMLNode]`, `any HTMLNode`, or erased child
boxes. The whole document type captures the exact child shape.

## 3. Can a renderer traverse this tree without dynamic casts?

Yes for this model.

Each node implements `render(into:)`, and the renderer calls that through a
generic method. `TupleNode` traverses its parameter-pack tuple with:

```swift
repeat renderer.render(each children)
```

No `as?`, `is`, or type-switch over `any HTMLNode` is needed.

Tradeoff: rendering behavior becomes part of each node conformance or must be
expressed through another statically-dispatched visitor-like protocol. A single
central renderer that pattern-matches arbitrary node values is not compatible
with the "no casts, no existential input" constraint.

## 4. How do conditionals work?

Conditionals can remain typed by lowering to concrete wrapper nodes:

- `if` without `else` becomes `OptionalNode<Content>`
- `if/else` becomes `EitherNode<First, Second>`

This preserves static typing and avoids existential erasure. The type can become
large as conditionals nest, but it compiles in the spike.

## 5. How do loops/dynamic arrays work?

Simple result-builder `for` loops work when every iteration produces the same
concrete node type. The builder lowers those to:

```swift
ArrayNode<Content>
```

which stores `[Content]`, not `[any HTMLNode]`.

This supports dynamic length with homogeneous element type. It does not support
a dynamic collection of heterogeneous arbitrary node types without adding
another representation.

## 6. Is `ForEach` needed as a special node?

Probably yes for ergonomics and control.

The spike includes:

```swift
ForEach(items) { item in
    P {
        TextNode(item)
    }
}
```

This stores the source sequence and a typed content closure. It avoids relying
only on result-builder `buildArray` and gives SwiftHTML an explicit place for
dynamic repeated content. It still requires the generated content to have one
concrete `Content: HTMLNode` type.

If SwiftHTML needs truly heterogeneous dynamic children, the options are:

- introduce a concrete enum AST node for the supported node cases,
- introduce typed dynamic nodes such as `ForEach`,
- or fall back to existential storage for that specific dynamic boundary.

## 7. Does this work with Embedded Swift?

Normal `swift build` validates the package, and `swift run
TypedHTMLTreeSpikeDemo` executes the renderer assertions.

The requested `swift-6.3.3-RELEASE_wasm-embedded` SDK is installed locally, but
the embedded build could not validate this spike because the host compiler is
Swift 6.4 and rejects the SDK's Swift 6.3.3 standard library module:

```text
module compiled with Swift 6.3.3 cannot be imported by the Swift 6.4 compiler
```

That failure happens before the compiler type-checks this package's source for
Embedded Swift, so it is an SDK/toolchain compatibility result rather than a
typed-tree model result.

The demo executable was also moved into `@main struct Demo` to avoid top-level
global `let` declarations for typed HTML tree values.

## 8. Does the API remain acceptable?

For static documents and homogeneous dynamic regions, the authoring syntax is
acceptable and close to the current SwiftHTML style:

```swift
let document = HTML {
    Body {
        H1 {
            "Hello"
        }

        ForEach(items) { item in
            P {
                TextNode(item)
            }
        }
    }
}
```

The main cost is type complexity. Public APIs that expose full document types
will expose deeply nested generic signatures unless hidden behind opaque return
types (`some HTMLNode`) or kept local.

## Validation

Passed:

- `swift build`
- `swift run TypedHTMLTreeSpikeDemo`

Not validated because of local toolchain/SDK mismatch:

- `swift build --swift-sdk swift-6.3.3-RELEASE_wasm-embedded`

Additional source scan:

- `Spikes/TypedHTMLTree/Sources` contains no `any HTMLNode`, `[any HTMLNode]`,
  `as?`, `is`, or `@unchecked` usage.

## Conclusion

B. Typed generic tree is viable only for static children; dynamic children need
a separate node.

Reason: the typed generic tree works well for static child lists, conditionals,
and homogeneous dynamic loops. Dynamic heterogeneous children still need an
explicit boundary: a concrete enum AST, a typed special node such as `ForEach`,
or existential storage at that boundary.
