//
//  HTMLStringOutputStream.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

import Foundation

public final class HTMLStringOutputStream: HTMLOutputStream {
    
    public private(set) var output: String
    
    public init(output: String = "") {
        self.output = output
    }
    
    public func write(_ string: String) {
        output += string
    }
    
    public func writeEscaped(_ string: String) {
        output += string
            .replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
    }
    
    public func writeDoubleQuoted(_ string: String) {
        write("\"")
        writeEscaped(string)
        write("\"")
    }
}
