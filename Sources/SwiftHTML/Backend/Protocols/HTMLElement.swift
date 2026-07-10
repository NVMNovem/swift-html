public protocol HTMLElement: HTMLNodeConvertible {
    var tag: String { get }
    var attributes: [Attribute] { get }
}

public extension HTMLElement {
    var attributes: [Attribute] { [] }
}
