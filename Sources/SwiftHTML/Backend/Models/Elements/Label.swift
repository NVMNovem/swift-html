//
//  Label.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 01/07/2026.
//

public struct Label: ContainerElement, Sendable {

    public let tag = "label"
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
