//
//  H2.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct H2: ContainerElement, Sendable {

    public let tag = "h2"
    public let attributes: [Attribute]
    public let children: [HTMLNode]

    public init(
        _ attributes: [Attribute],
        @HTMLBuilder children: () -> [HTMLNode]
    ) {
        self.attributes = attributes
        self.children = children()
    }
}
