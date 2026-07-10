public struct HTMLDocument: HTMLNodeConvertible, Sendable {
    public let htmlNode: HTMLNode

    public init(@HTMLBuilder children: () -> [HTMLNode]) {
        self.htmlNode = .document(HTMLDocumentNode(children: children()))
    }
}
