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
    
    func renderOpeningTag(
        using renderer: HTMLRenderer
    ) {
        renderer.write("<")
        renderer.write(tag)
        
        for attribute in attributes {
            renderer.write(" ")
            renderer.write(attribute.key)
            renderer.write("=")
            renderer.writeDoubleQuoted(attribute.value)
        }
        
        renderer.write(">")
    }
}
