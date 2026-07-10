public struct RawText: HTMLNodeConvertible, Sendable {
    public let htmlNode: HTMLNode

    public init(_ content: String) {
        self.htmlNode = .rawText(content)
    }
}
