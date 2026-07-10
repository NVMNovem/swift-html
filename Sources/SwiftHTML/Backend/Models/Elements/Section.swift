//
//  Section.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public struct Section: ContainerElement, Sendable {

    public let tag = "section"
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
