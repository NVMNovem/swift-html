import TypedHTMLTreeSpike

@main
struct Demo {
    static func main() {
        let document = HTML {
            Body {
                H1 {
                    TextNode("Hello")
                }

                P {
                    TextNode("Intro")
                }
            }
        }

        expectEqual(document.render(), "<html><body><h1>Hello</h1><p>Intro</p></body></html>")

        let showSubtitle = true
        let useIntro = false

        let conditionalDocument = Body {
            H1 {
                "Hello"
            }

            if showSubtitle {
                P {
                    "Subtitle"
                }
            }

            if useIntro {
                P {
                    "Intro"
                }
            } else {
                P {
                    "Fallback"
                }
            }
        }

        expectEqual(conditionalDocument.render(), "<body><h1>Hello</h1><p>Subtitle</p><p>Fallback</p></body>")

        let loopItems = ["One", "Two", "<Three>"]

        let loopDocument = Body {
            for item in loopItems {
                P {
                    TextNode(item)
                }
            }
        }

        expectEqual(loopDocument.render(), "<body><p>One</p><p>Two</p><p>&lt;Three&gt;</p></body>")

        let forEachDocument = Body {
            H1 {
                "Items"
            }

            ForEach(["One", "Two"]) { item in
                P {
                    TextNode(item)
                }
            }
        }

        expectEqual(forEachDocument.render(), "<body><h1>Items</h1><p>One</p><p>Two</p></body>")

        print("TypedHTMLTreeSpike demo passed")
    }

    private static func expectEqual(
        _ actual: String,
        _ expected: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        precondition(actual == expected, "Expected \(expected), got \(actual)", file: file, line: line)
    }
}
