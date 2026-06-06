//
//  HTMLDocument.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public struct HTMLDocument: HTMLNode {

    public let children: [any HTMLNode]

    public init(
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.children = children()
    }

    public func render(using renderer: HTMLRenderer) {
        renderer.write("<!DOCTYPE html>")

        for child in children {
            renderer.writeLineBreak()
            child.render(using: renderer)
        }
    }
}
