//
//  Div.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct Div: ContainerElement {
    
    public let tag = "div"
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
