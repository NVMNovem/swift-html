public struct HTMLTreeDumpRenderer: HTMLRendererProtocol {
    public init() {}

    public func render(_ node: HTMLNode) -> String {
        var lines: [String] = []
        render(node, level: 0, into: &lines)
        return lines.joined(separator: "\n")
    }

    public func render<Node: HTMLNodeConvertible>(_ node: Node) -> String { render(node.htmlNode) }

    private func render(_ node: HTMLNode, level: Int, into lines: inout [String]) {
        let prefix = String(repeating: "  ", count: level)
        switch node {
        case .document(let document):
            lines.append(prefix + "HTMLDocument")
            for child in document.children { render(child, level: level + 1, into: &lines) }
        case .element(let element):
            lines.append(prefix + element.tag + attributesDescription(for: element.attributes))
            for child in element.children { render(child, level: level + 1, into: &lines) }
        case .text(let text): lines.append(prefix + "Text(\"\(readable(text))\")")
        case .rawText(let text): lines.append(prefix + "RawText(\"\(readable(text))\")")
        }
    }

    private func attributesDescription(for attributes: [Attribute]) -> String {
        guard !attributes.isEmpty else { return "" }
        return " [" + attributes.map { "\($0.key)=\"\(readable($0.value))\"" }.joined(separator: " ") + "]"
    }

    private func readable(_ string: String) -> String {
        var output = ""
        for character in string {
            switch character {
            case "\\": output += "\\\\"
            case "\n": output += "\\n"
            case "\t": output += "\\t"
            case "\"": output += "\\\""
            default: output.append(character)
            }
        }
        return output
    }
}
