//
//  Body.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct Body: ContainerElement {

    public let tag = "body"
    public let children: [any HTMLNode]

    public init(
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.children = children()
    }
}
