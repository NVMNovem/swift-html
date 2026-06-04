//
//  H3.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct H3: ContainerElement {

    public let tag = "h3"
    public let children: [any HTMLNode]

    public init(
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.children = children()
    }
}
