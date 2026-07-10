//
//  Body.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct Body: ContainerElement, Sendable {

    public let tag = "body"
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
