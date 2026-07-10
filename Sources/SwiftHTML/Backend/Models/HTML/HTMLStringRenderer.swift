public struct HTMLStringRenderer: HTMLRendererProtocol {
    public let options: HTMLRenderOptions

    public init(options: HTMLRenderOptions = .init()) { self.options = options }

    public func render(_ node: HTMLNode) -> String {
        let stream = HTMLStringOutputStream()
        var context = HTMLRenderContext(options: options)
        render(node, to: stream, context: &context)
        return stream.output
    }

    public func render<Node: HTMLNodeConvertible>(_ node: Node) -> String { render(node.htmlNode) }

    private func render(_ node: HTMLNode, to stream: HTMLStringOutputStream, context: inout HTMLRenderContext) {
        switch node {
        case .document(let document):
            stream.write("<!DOCTYPE html>")
            for child in document.children {
                writeLineBreak(to: stream, context: context)
                render(child, to: stream, context: &context)
            }
        case .element(let element):
            renderOpeningTag(element, to: stream)
            guard !element.isVoid else { return }
            if shouldPrettyPrintChildren(element.children, context: context) {
                context.indentationLevel += 1
                for child in element.children {
                    writeLineBreak(to: stream, context: context)
                    writeIndentation(to: stream, context: context)
                    render(child, to: stream, context: &context)
                }
                context.indentationLevel = max(0, context.indentationLevel - 1)
                writeLineBreak(to: stream, context: context)
                writeIndentation(to: stream, context: context)
            } else {
                for child in element.children { render(child, to: stream, context: &context) }
            }
            stream.write("</")
            stream.write(element.tag)
            stream.write(">")
        case .text(let text): stream.writeEscaped(text)
        case .rawText(let rawText): stream.write(rawText)
        }
    }

    private func renderOpeningTag(_ element: HTMLElementNode, to stream: HTMLStringOutputStream) {
        stream.write("<")
        stream.write(element.tag)
        for attribute in element.attributes {
            stream.write(" ")
            stream.write(attribute.key)
            stream.write("=")
            stream.writeDoubleQuoted(attribute.value)
        }
        stream.write(">")
    }

    private func writeLineBreak(to stream: HTMLStringOutputStream, context: HTMLRenderContext) {
        if context.options.prettyPrinted { stream.write("\n") }
    }

    private func writeIndentation(to stream: HTMLStringOutputStream, context: HTMLRenderContext) {
        guard context.options.prettyPrinted else { return }
        for _ in 0..<context.indentationLevel { stream.write(context.options.indentation) }
    }

    private func shouldPrettyPrintChildren(_ children: [HTMLNode], context: HTMLRenderContext) -> Bool {
        guard context.options.prettyPrinted else { return false }
        for child in children {
            if case .text = child { return false }
        }
        return !children.isEmpty
    }
}
