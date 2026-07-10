public indirect enum HTMLNode: Sendable {
    case document(HTMLDocumentNode)
    case element(HTMLElementNode)
    case text(String)
    case rawText(String)
}

public struct HTMLDocumentNode: Sendable {
    public let children: [HTMLNode]

    public init(children: [HTMLNode]) {
        self.children = children
    }
}

public struct HTMLElementNode: Sendable {
    public let tag: String
    public let attributes: [Attribute]
    public let children: [HTMLNode]
    public let isVoid: Bool

    public init(tag: String, attributes: [Attribute], children: [HTMLNode], isVoid: Bool) {
        self.tag = tag
        self.attributes = attributes
        self.children = children
        self.isVoid = isVoid
    }
}

public protocol HTMLNodeConvertible: Sendable {
    var htmlNode: HTMLNode { get }
}

extension HTMLNode: HTMLNodeConvertible {
    public var htmlNode: HTMLNode { self }
}

public extension HTMLNodeConvertible {
    func render(options: HTMLRenderOptions = .init()) -> String {
        HTMLStringRenderer(options: options).render(htmlNode)
    }

    func render(prettyPrinted: Bool) -> String {
        render(options: HTMLRenderOptions(prettyPrinted: prettyPrinted))
    }
}
