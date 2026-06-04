//
//  ContainerElement.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public protocol ContainerElement: HTMLElement {

    var children: [any HTMLNode] { get }
}

public extension ContainerElement {
    
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

        for child in children {
            child.render(into: stream)
        }

        stream.write("</")
        stream.write(tag)
        stream.write(">")
    }
}
