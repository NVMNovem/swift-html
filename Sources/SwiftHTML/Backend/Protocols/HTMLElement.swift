//
//  HTMLElement.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public protocol HTMLElement: HTMLNode {

    var tag: String { get }

    var attributes: [String: String] { get }
}

public extension HTMLElement {

    var attributes: [String: String] {
        [:]
    }
    
    func renderOpeningTag(
        using renderer: HTMLRenderer
    ) {
        renderer.write("<")
        renderer.write(tag)
        
        for key in attributes.keys.sorted() {
            guard let value = attributes[key] else {
                continue
            }
            
            renderer.write(" ")
            renderer.write(key)
            renderer.write("=")
            renderer.writeDoubleQuoted(value)
        }
        
        renderer.write(">")
    }
}
