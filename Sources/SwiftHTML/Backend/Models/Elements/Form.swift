//
//  Form.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 01/07/2026.
//

public struct Form: ContainerElement {

    public let tag = "form"
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
