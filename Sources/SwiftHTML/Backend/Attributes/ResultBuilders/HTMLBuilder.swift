//
//  HTMLBuilder.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

@resultBuilder
public enum HTMLBuilder {
    
    public static func buildBlock(_ components: [any HTMLNode]...) -> [any HTMLNode] {
        components.flatMap(\.self)
    }
    
    public static func buildExpression(_ expression: String) -> [any HTMLNode] {
        [TextNode(expression)]
    }
    
    public static func buildExpression(_ expression: any HTMLNode) -> [any HTMLNode] {
        [expression]
    }
    
    public static func buildArray(_ components: [[any HTMLNode]]) -> [any HTMLNode] {
        components.flatMap(\.self)
    }
    
    public static func buildOptional(_ component: [any HTMLNode]?) -> [any HTMLNode] {
        component ?? []
    }
    
    public static func buildEither(first component: [any HTMLNode]) -> [any HTMLNode] {
        component
    }
    
    public static func buildEither(second component: [any HTMLNode]) -> [any HTMLNode] {
        component
    }
}
