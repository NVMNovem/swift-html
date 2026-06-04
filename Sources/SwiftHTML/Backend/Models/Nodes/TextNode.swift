//
//  TextNode.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public struct TextNode: HTMLNode {
    
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
    
    public func render(into stream: HTMLOutputStream) {
        stream.writeEscaped(value)
    }
}
