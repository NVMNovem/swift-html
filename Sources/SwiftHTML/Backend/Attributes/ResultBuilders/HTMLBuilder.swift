//
//  HTMLBuilder.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 10/07/2026.
//

@resultBuilder
public enum HTMLBuilder {
    
    public static func buildBlock(_ components: [HTMLNode]...) -> [HTMLNode] {
        components.flatMap { $0 }
    }

    public static func buildExpression(_ expression: String) -> [HTMLNode] {
        [.text(expression)]
    }

    public static func buildExpression(_ expression: HTMLNode) -> [HTMLNode] {
        [expression]
    }

    public static func buildExpression<Node: HTMLNodeConvertible>(_ expression: Node) -> [HTMLNode] {
        [expression.htmlNode]
    }

    public static func buildArray(_ components: [[HTMLNode]]) -> [HTMLNode] {
        components.flatMap { $0 }
    }

    public static func buildOptional(_ component: [HTMLNode]?) -> [HTMLNode] {
        component ?? []
    }
    
    public static func buildEither(first component: [HTMLNode]) -> [HTMLNode] {
        component
    }
    
    public static func buildEither(second component: [HTMLNode]) -> [HTMLNode] {
        component
    }
}
