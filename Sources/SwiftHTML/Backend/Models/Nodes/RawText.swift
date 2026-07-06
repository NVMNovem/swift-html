//
//  RawText.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct RawText: HTMLNode {

    public let content: String

    public init(_ content: String) {
        self.content = content
    }
}
