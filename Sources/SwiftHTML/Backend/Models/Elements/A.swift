//
//  A.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct A: ContainerElement, Sendable {
    
    public let tag = "a"
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
