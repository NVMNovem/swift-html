//
//  ContainerElement.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public protocol ContainerElement: HTMLElement {
    
    var children: [any HTMLNode] { get }
    
    init(
        _ attributes: [Attribute],
        @HTMLBuilder children: () -> [any HTMLNode]
    )
}

public extension ContainerElement {
    
    init(
        _ attributes: Attribute...,
        @HTMLBuilder children: () -> [any HTMLNode]
    ) {
        self.init(attributes, children: children)
    }
}
