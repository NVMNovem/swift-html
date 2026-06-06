//
//  HTMLNode.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public protocol HTMLNode {
    
    func render(using renderer: HTMLRenderer)
}

public extension HTMLNode {
    
    func render(
        options: HTMLRenderOptions = .init()
    ) -> String {
        HTMLRenderer(options: options).render(self)
    }
    
    func render(prettyPrinted: Bool) -> String {
        render(
            options: HTMLRenderOptions(
                prettyPrinted: prettyPrinted
            )
        )
    }
}
