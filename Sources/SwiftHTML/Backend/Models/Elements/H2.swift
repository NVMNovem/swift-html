//
//  H2.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct H2: ContainerElement {

    public let tag = "h2"
    public let children: [any HTMLNode]

    public init(
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.children = children()
    }
}
