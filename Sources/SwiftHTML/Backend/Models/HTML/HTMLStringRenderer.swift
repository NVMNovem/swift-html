//
//  HTMLStringRenderer.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public struct HTMLStringRenderer {

    public let options: HTMLRenderOptions

    public init(options: HTMLRenderOptions = .init()) {
        self.options = options
    }

    public func render(_ node: any HTMLNode) -> String {
        let stream = HTMLStringOutputStream()
        var context = HTMLRenderContext(options: options)
        render(node, to: stream, context: &context)
        return stream.output
    }

    private func render(
        _ node: any HTMLNode,
        to stream: HTMLStringOutputStream,
        context: inout HTMLRenderContext
    ) {
        switch node {
        case let document as HTMLDocument:
            renderDocument(document, to: stream, context: &context)
        case let text as TextNode:
            stream.writeEscaped(text.value)
        case let rawText as RawText:
            stream.write(rawText.content)
        case let element as any VoidElement:
            renderOpeningTag(element, to: stream)
        case let element as any ContainerElement:
            renderContainerElement(element, to: stream, context: &context)
        case let element as any HTMLElement:
            renderOpeningTag(element, to: stream)
        default:
            break
        }
    }

    private func renderDocument(
        _ document: HTMLDocument,
        to stream: HTMLStringOutputStream,
        context: inout HTMLRenderContext
    ) {
        stream.write("<!DOCTYPE html>")

        for child in document.children {
            writeLineBreak(to: stream, context: context)
            render(child, to: stream, context: &context)
        }
    }

    private func renderContainerElement(
        _ element: any ContainerElement,
        to stream: HTMLStringOutputStream,
        context: inout HTMLRenderContext
    ) {
        renderOpeningTag(element, to: stream)

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
            for child in element.children {
                render(child, to: stream, context: &context)
            }
        }

        stream.write("</")
        stream.write(element.tag)
        stream.write(">")
    }

    private func renderOpeningTag(
        _ element: any HTMLElement,
        to stream: HTMLStringOutputStream
    ) {
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

    private func writeLineBreak(
        to stream: HTMLStringOutputStream,
        context: HTMLRenderContext
    ) {
        guard context.options.prettyPrinted else {
            return
        }

        stream.write("\n")
    }

    private func writeIndentation(
        to stream: HTMLStringOutputStream,
        context: HTMLRenderContext
    ) {
        guard context.options.prettyPrinted else {
            return
        }

        for _ in 0..<context.indentationLevel {
            stream.write(context.options.indentation)
        }
    }

    private func shouldPrettyPrintChildren(
        _ children: [any HTMLNode],
        context: HTMLRenderContext
    ) -> Bool {
        context.options.prettyPrinted
            && children.contains { !($0 is TextNode) }
            && children.allSatisfy { !($0 is TextNode) }
    }
}
