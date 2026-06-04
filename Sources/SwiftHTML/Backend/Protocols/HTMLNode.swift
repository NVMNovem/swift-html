//
//  HTMLNode.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public protocol HTMLNode {

    func render(into stream: HTMLOutputStream)
}

public extension HTMLNode {
    
    func render() -> String {
        let stream = HTMLStringOutputStream()
        render(into: stream)
        return stream.output
    }
}
