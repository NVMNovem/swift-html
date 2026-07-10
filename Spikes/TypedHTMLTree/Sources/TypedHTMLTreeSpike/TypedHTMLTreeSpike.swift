public enum NodeKind: Equatable, Sendable {
    case element
    case text
    case empty
    case tuple
    case optional
    case either
    case array
}

public protocol HTMLNode: Sendable {
    static var kind: NodeKind { get }

    func render(into renderer: inout HTMLRenderer)
}

public extension HTMLNode {
    func render() -> String {
        var renderer = HTMLRenderer()
        render(into: &renderer)
        return renderer.output
    }
}

public protocol HTMLTag: Sendable {
    static var name: String { get }
}

public struct HTMLTagName: HTMLTag {
    public static let name = "html"
}

public struct BodyTagName: HTMLTag {
    public static let name = "body"
}

public struct H1TagName: HTMLTag {
    public static let name = "h1"
}

public struct PTagName: HTMLTag {
    public static let name = "p"
}

public struct Element<Tag: HTMLTag, Content: HTMLNode>: HTMLNode {
    public static var kind: NodeKind { .element }

    public let content: Content

    public init(@HTMLBuilder content: () -> Content) {
        self.content = content()
    }

    public func render(into renderer: inout HTMLRenderer) {
        renderer.renderElement(self)
    }
}

public typealias HTML<Content: HTMLNode> = Element<HTMLTagName, Content>
public typealias Body<Content: HTMLNode> = Element<BodyTagName, Content>
public typealias H1<Content: HTMLNode> = Element<H1TagName, Content>
public typealias P<Content: HTMLNode> = Element<PTagName, Content>

public struct TextNode: HTMLNode {
    public static let kind: NodeKind = .text

    public let text: String

    public init(_ text: String) {
        self.text = text
    }

    public func render(into renderer: inout HTMLRenderer) {
        renderer.renderText(self)
    }
}

public struct EmptyNode: HTMLNode {
    public static let kind: NodeKind = .empty

    public init() {}

    public func render(into renderer: inout HTMLRenderer) {
        renderer.renderEmpty(self)
    }
}

public struct TupleNode<each Child: HTMLNode>: HTMLNode {
    public static var kind: NodeKind { .tuple }

    public let children: (repeat each Child)

    public init(_ children: repeat each Child) {
        self.children = (repeat each children)
    }

    public func render(into renderer: inout HTMLRenderer) {
        renderer.renderTuple(self)
    }
}

public struct OptionalNode<Content: HTMLNode>: HTMLNode {
    public static var kind: NodeKind { .optional }

    public let content: Content?

    public init(_ content: Content?) {
        self.content = content
    }

    public func render(into renderer: inout HTMLRenderer) {
        renderer.renderOptional(self)
    }
}

public enum EitherNode<First: HTMLNode, Second: HTMLNode>: HTMLNode {
    public static var kind: NodeKind { .either }

    case first(First)
    case second(Second)

    public func render(into renderer: inout HTMLRenderer) {
        renderer.renderEither(self)
    }
}

public struct ArrayNode<Content: HTMLNode>: HTMLNode {
    public static var kind: NodeKind { .array }

    public let children: [Content]

    public init(_ children: [Content]) {
        self.children = children
    }

    public func render(into renderer: inout HTMLRenderer) {
        renderer.renderArray(self)
    }
}

public struct ForEach<Data: Sequence & Sendable, Content: HTMLNode>: HTMLNode {
    public static var kind: NodeKind { .array }

    public let data: Data
    public let content: @Sendable (Data.Element) -> Content

    public init(
        _ data: Data,
        @HTMLBuilder content: @escaping @Sendable (Data.Element) -> Content
    ) {
        self.data = data
        self.content = content
    }

    public func render(into renderer: inout HTMLRenderer) {
        renderer.renderForEach(self)
    }
}

@resultBuilder
public enum HTMLBuilder {
    public static func buildBlock() -> EmptyNode {
        EmptyNode()
    }

    public static func buildBlock<each Content: HTMLNode>(
        _ content: repeat each Content
    ) -> TupleNode<repeat each Content> {
        TupleNode(repeat each content)
    }

    public static func buildExpression(_ expression: String) -> TextNode {
        TextNode(expression)
    }

    public static func buildExpression<Content: HTMLNode>(
        _ expression: Content
    ) -> Content {
        expression
    }

    public static func buildOptional<Content: HTMLNode>(
        _ component: Content?
    ) -> OptionalNode<Content> {
        OptionalNode(component)
    }

    public static func buildEither<First: HTMLNode, Second: HTMLNode>(
        first component: First
    ) -> EitherNode<First, Second> {
        .first(component)
    }

    public static func buildEither<First: HTMLNode, Second: HTMLNode>(
        second component: Second
    ) -> EitherNode<First, Second> {
        .second(component)
    }

    public static func buildArray<Content: HTMLNode>(
        _ components: [Content]
    ) -> ArrayNode<Content> {
        ArrayNode(components)
    }
}

public struct HTMLRenderer: Sendable {
    public private(set) var output = ""

    public init() {}

    public mutating func renderElement<Tag: HTMLTag, Content: HTMLNode>(
        _ node: Element<Tag, Content>
    ) {
        write("<")
        write(Tag.name)
        write(">")
        node.content.render(into: &self)
        write("</")
        write(Tag.name)
        write(">")
    }

    public mutating func renderText(_ node: TextNode) {
        writeEscaped(node.text)
    }

    public mutating func renderEmpty(_ node: EmptyNode) {}

    public mutating func renderTuple<each Child: HTMLNode>(
        _ node: TupleNode<repeat each Child>
    ) {
        repeat (each node.children).render(into: &self)
    }

    public mutating func renderOptional<Content: HTMLNode>(
        _ node: OptionalNode<Content>
    ) {
        if let content = node.content {
            content.render(into: &self)
        }
    }

    public mutating func renderEither<First: HTMLNode, Second: HTMLNode>(
        _ node: EitherNode<First, Second>
    ) {
        switch node {
        case .first(let first):
            first.render(into: &self)
        case .second(let second):
            second.render(into: &self)
        }
    }

    public mutating func renderArray<Content: HTMLNode>(
        _ node: ArrayNode<Content>
    ) {
        for child in node.children {
            child.render(into: &self)
        }
    }

    public mutating func renderForEach<Data: Sequence & Sendable, Content: HTMLNode>(
        _ node: ForEach<Data, Content>
    ) {
        for element in node.data {
            node.content(element).render(into: &self)
        }
    }

    public mutating func write(_ value: String) {
        output += value
    }

    public mutating func writeEscaped(_ value: String) {
        for character in value {
            switch character {
            case "&":
                output += "&amp;"
            case "<":
                output += "&lt;"
            case ">":
                output += "&gt;"
            case "\"":
                output += "&quot;"
            default:
                output.append(character)
            }
        }
    }
}
