//
//  HTML.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct HTML: ContainerElement {

    public let tag = "html"
    public let children: [any HTMLNode]

    public init(
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.children = children()
    }
}
