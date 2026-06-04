//
//  VoidElement.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//


public protocol VoidElement: HTMLElement {}

public extension VoidElement {
    
    func render(into stream: HTMLOutputStream) {
        stream.write("<")
        stream.write(tag)

        for key in attributes.keys.sorted() {
            guard let value = attributes[key] else {
                continue
            }

            stream.write(" ")
            stream.write(key)
            stream.write("=")
            stream.writeDoubleQuoted(value)
        }

        stream.write(">")
    }
}
