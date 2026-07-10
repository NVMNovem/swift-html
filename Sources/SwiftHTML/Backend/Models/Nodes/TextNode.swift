public struct TextNode: HTMLNodeConvertible, Sendable {
    public let htmlNode: HTMLNode

    public init(_ value: String) {
        self.htmlNode = .text(value)
    }
}
