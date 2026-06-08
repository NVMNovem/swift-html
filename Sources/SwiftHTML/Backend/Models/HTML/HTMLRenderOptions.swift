//
//  HTMLRenderOptions.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public struct HTMLRenderOptions {
    
    public var prettyPrinted: Bool
    public var indentation: String

    public init(
        prettyPrinted: Bool = false,
        indentation: String = "    "
    ) {
        self.prettyPrinted = prettyPrinted
        self.indentation = indentation
    }
}
