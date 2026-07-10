//
//  Article.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public struct Article: ContainerElement, Sendable {

    public let tag = "article"
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
