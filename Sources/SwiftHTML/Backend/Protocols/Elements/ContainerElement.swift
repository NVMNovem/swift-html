public protocol ContainerElement: HTMLElement {
    var children: [HTMLNode] { get }
    init(_ attributes: [Attribute], @HTMLBuilder children: () -> [HTMLNode])
}

public extension ContainerElement {
    init(_ attributes: Attribute..., @HTMLBuilder children: () -> [HTMLNode]) {
        self.init(attributes, children: children)
    }

    var htmlNode: HTMLNode {
        .element(HTMLElementNode(tag: tag, attributes: attributes, children: children, isVoid: false))
    }
}
