//
//  HTMLTreeDumpRenderer.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/07/2026.
//

public struct HTMLTreeDumpRenderer: HTMLRendererProtocol {

    public init() {}

    public func render(_ node: any HTMLNode) -> String {
        var lines: [String] = []
        render(node, level: 0, into: &lines)
        return lines.joined(separator: "\n")
    }

    private func render(
        _ node: any HTMLNode,
        level: Int,
        into lines: inout [String]
    ) {
        lines.append("\(indentation(for: level))\(description(for: node))")

        if let document = node as? HTMLDocument {
            for child in document.children {
                render(child, level: level + 1, into: &lines)
            }
        } else if let element = node as? any ContainerElement {
            for child in element.children {
                render(child, level: level + 1, into: &lines)
            }
        }
    }

    private func description(for node: any HTMLNode) -> String {
        switch node {
        case is HTMLDocument:
            "HTMLDocument"
        case let text as TextNode:
            "Text(\"\(readable(text.value))\")"
        case let rawText as RawText:
            "RawText(\"\(readable(rawText.content))\")"
        case let element as any VoidElement:
            "\(element.tag)\(attributesDescription(for: element.attributes))"
        case let element as any HTMLElement:
            "\(element.tag)\(attributesDescription(for: element.attributes))"
        default:
            String(describing: type(of: node))
        }
    }

    private func attributesDescription(for attributes: [Attribute]) -> String {
        guard !attributes.isEmpty else {
            return ""
        }

        let attributes = attributes
            .map { "\($0.key)=\"\(readable($0.value))\"" }
            .joined(separator: " ")

        return " [\(attributes)]"
    }

    private func readable(_ string: String) -> String {
        string
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\n", with: "\\n")
            .replacingOccurrences(of: "\t", with: "\\t")
            .replacingOccurrences(of: "\"", with: "\\\"")
    }

    private func indentation(for level: Int) -> String {
        String(repeating: "  ", count: level)
    }
}
