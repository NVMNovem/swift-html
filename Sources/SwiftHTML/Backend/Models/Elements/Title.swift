//
//  Title.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public struct Title: ContainerElement {

    public let tag = "title"
    public let attributes: [Attribute]
    public let children: [any HTMLNode]

    public init(
        _ attributes: Attribute...,
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.attributes = attributes
        self.children = children()
    }
}
