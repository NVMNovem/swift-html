//
//  Meta.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public struct Meta: VoidElement, Sendable {

    public let tag = "meta"
    public let attributes: [Attribute]

    public init(_ attributes: Attribute...) {
        self.attributes = attributes
    }
}
