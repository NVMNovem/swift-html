//
//  Input.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 01/07/2026.
//

public struct Input: VoidElement {

    public let tag = "input"
    public let attributes: [Attribute]

    public init(_ attributes: Attribute...) {
        self.attributes = attributes
    }
}
