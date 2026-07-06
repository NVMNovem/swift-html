//
//  HTMLDocument.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public struct HTMLDocument: HTMLNode {

    public let children: [any HTMLNode]

    public init(
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.children = children()
    }
}
