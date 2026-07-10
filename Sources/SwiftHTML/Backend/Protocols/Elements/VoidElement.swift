public protocol VoidElement: HTMLElement {}

public extension VoidElement {
    var htmlNode: HTMLNode {
        .element(HTMLElementNode(tag: tag, attributes: attributes, children: [], isVoid: true))
    }
}
