//
//  Template.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 05/07/2026.
//

public struct Template: ContainerElement {

    public let tag = "template"
    public let attributes: [Attribute]
    public let children: [any HTMLNode]

    public init(
        _ attributes: [Attribute],
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.attributes = attributes
        self.children = children()
    }
}
