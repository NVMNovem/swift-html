//
//  Img.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 20/06/2026.
//

public struct Img: VoidElement, Sendable {

    public let tag = "img"
    public let attributes: [Attribute]

    public init(_ attributes: Attribute...) {
        self.attributes = attributes
    }
}
