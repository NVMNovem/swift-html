//
//  A.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct A: ContainerElement {
    
    public let tag = "a"
    public let href: String?
    public let children: [any HTMLNode]

    public var attributes: [String: String] {
        guard let href else {
            return [:]
        }

        return [
            "href": href
        ]
    }
    
    public init(
        href: String? = nil,
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.href = href
        self.children = children()
    }
}
