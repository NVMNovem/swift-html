//
//  HTMLElement.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public protocol HTMLElement: HTMLNode {

    var tag: String { get }

    var attributes: [Attribute] { get }
}

public extension HTMLElement {

    var attributes: [Attribute] {
        []
    }
}
