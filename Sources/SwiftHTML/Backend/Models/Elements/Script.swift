//
//  Script.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct Script: ContainerElement, Sendable {

    public let tag = "script"
    public let attributes: [Attribute]
    public let children: [HTMLNode]

    public init(
        _ attributes: [Attribute],
    ) {
        self.attributes = attributes
        self.children = []
    }

    public init(
        _ attributes: Attribute...,
    ) {
        self.attributes = attributes
        self.children = []
    }

    public init(
        _ attributes: [Attribute],
        @HTMLBuilder children: () -> [HTMLNode]
    ) {
        self.attributes = attributes
        self.children = children()
    }

    public init(
        _ attributes: Attribute...,
        @HTMLBuilder children: () -> [HTMLNode]
    ) {
        self.attributes = attributes
        self.children = children()
    }
}
