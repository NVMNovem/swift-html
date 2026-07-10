//
//  HTMLRendererProtocol.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/07/2026.
//

public protocol HTMLRendererProtocol {

    associatedtype Output

    func render(_ node: HTMLNode) -> Output
}
