//
//  Script.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct Script: ContainerElement {

    public let tag = "script"
    public let attributes: [Attribute]
    public let children: [any HTMLNode]

    public init(
        _ attributes: Attribute...
    ) {
        self.attributes = attributes
        self.children = []
    }

    public init(
        _ attributes: Attribute...,
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.attributes = attributes
        self.children = children()
    }
}
