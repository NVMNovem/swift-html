//
//  H1.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct H1: ContainerElement {

    public let tag = "h1"
    public let children: [any HTMLNode]

    public init(
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.children = children()
    }
}
