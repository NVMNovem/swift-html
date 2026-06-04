//
//  HTMLOutputStream.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 04/06/2026.
//

public protocol HTMLOutputStream: AnyObject {
    
    func write(_ string: String)
    func writeEscaped(_ string: String)
    func writeDoubleQuoted(_ string: String)
}
