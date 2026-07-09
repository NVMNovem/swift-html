//
//  HTMLStringOutputStream.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public final class HTMLStringOutputStream: HTMLOutputStream {
    
    public private(set) var output: String
    
    public init(output: String = "") {
        self.output = output
    }
    
    public func write(_ string: String) {
        output += string
    }
    
    public func writeEscaped(_ string: String) {
        for character in string {
            switch character {
            case "&": output += "&amp;"
            case "<": output += "&lt;"
            case ">": output += "&gt;"
            case "\"": output += "&quot;"
            default: output.append(character)
            }
        }
    }
    
    public func writeDoubleQuoted(_ string: String) {
        write("\"")
        writeEscaped(string)
        write("\"")
    }
}
