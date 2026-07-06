# SwiftHTML Architecture

SwiftHTML is an HTML AST and model layer.

The model owns the tree shape:

- `HTMLNode` marks values that can appear in the tree.
- `HTMLElement` stores an HTML tag and attributes.
- `ContainerElement` stores child nodes.
- `VoidElement` marks elements that do not render a closing tag.
- Concrete nodes such as `TextNode`, `RawText`, and `HTMLDocument` store content and structure.

Model types do not own rendering decisions. They do not write output, escape text, choose indentation, traverse children for output, or emit opening and closing tags.

Renderers own output. `HTMLRendererProtocol` defines the renderer boundary: a renderer accepts any `HTMLNode` tree and returns its own output type.

`HTMLStringRenderer` renders HTML text. It owns string output concerns:

- document doctype
- opening and closing tags
- void element output
- attributes
- text escaping
- raw text
- indentation
- pretty printing
- child traversal

`HTMLTreeDumpRenderer` renders a debug representation of the same tree. It is useful for inspecting structure and validating that renderers can traverse the model independently.

Future renderers, such as a `DOMRenderer` or `WASMRenderer`, can traverse the same tree and produce a different output target without changing element models.
