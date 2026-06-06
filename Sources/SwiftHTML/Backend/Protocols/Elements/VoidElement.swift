//
//  VoidElement.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public protocol VoidElement: HTMLElement {}

public extension VoidElement {
    
    func render(using renderer: HTMLRenderer) {
        renderOpeningTag(using: renderer)
    }
}
