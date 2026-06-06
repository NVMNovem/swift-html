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
    
    func render(using renderer: HTMLRenderer) {
        renderOpeningTag(using: renderer)
        
        if renderer.shouldPrettyPrintChildren(children) {
            renderer.increaseIndentation()
            
            for child in children {
                renderer.writeLineBreak()
                renderer.writeIndentation()
                child.render(using: renderer)
            }
            
            renderer.decreaseIndentation()
            renderer.writeLineBreak()
            renderer.writeIndentation()
        } else {
            for child in children {
                child.render(using: renderer)
            }
        }
        
        renderer.write("</")
        renderer.write(tag)
        renderer.write(">")
    }
}
