//
//  HTMLRenderer.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public final class HTMLRenderer {
    
    private let stream: HTMLOutputStream
    private var context: HTMLRenderContext
    
    public init(
        stream: HTMLOutputStream,
        options: HTMLRenderOptions = .init()
    ) {
        self.stream = stream
        self.context = HTMLRenderContext(options: options)
    }
    
    public convenience init(
        options: HTMLRenderOptions = .init()
    ) {
        self.init(
            stream: HTMLStringOutputStream(),
            options: options
        )
    }
    
    public func write(_ string: String) {
        stream.write(string)
    }
    
    public func writeEscaped(_ string: String) {
        stream.writeEscaped(string)
    }
    
    public func writeDoubleQuoted(_ string: String) {
        stream.writeDoubleQuoted(string)
    }
    
    public func writeLineBreak() {
        guard context.options.prettyPrinted else {
            return
        }
        
        stream.write("\n")
    }
    
    public func writeIndentation() {
        guard context.options.prettyPrinted else {
            return
        }
        
        for _ in 0..<context.indentationLevel {
            stream.write(context.options.indentation)
        }
    }
    
    public func increaseIndentation() {
        context.indentationLevel += 1
    }
    
    public func decreaseIndentation() {
        context.indentationLevel = max(0, context.indentationLevel - 1)
    }
    
    public func render(_ node: any HTMLNode) -> String {
        node.render(using: self)
        
        guard let stream = stream as? HTMLStringOutputStream else {
            return ""
        }
        
        return stream.output
    }
    
    func shouldPrettyPrintChildren(_ children: [any HTMLNode]) -> Bool {
        context.options.prettyPrinted
            && children.contains { !($0 is TextNode) }
            && children.allSatisfy { !($0 is TextNode) }
    }
}
