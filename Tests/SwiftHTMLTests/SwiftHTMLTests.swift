import Testing
@testable import SwiftHTML

@Test
func rendersTextEscaped() async throws {
    let textNode = TextNode("Hello <Swift> & \"HTML\"")
    
    #expect(textNode.render() == "Hello &lt;Swift&gt; &amp; &quot;HTML&quot;")
}

@Test
func rendersSimpleElement() async throws {
    let div = Div {
        "Hello"
    }
    
    #expect(div.render() == "<div>Hello</div>")
}

@Test
func rendersNestedElements() async throws {
    let div = Div {
        H1 {
            "SwiftHTML"
        }
        
        P {
            "Swift is awesome!"
        }
    }
    
    #expect(div.render() == "<div><h1>SwiftHTML</h1><p>Swift is awesome!</p></div>")
}

@Test
func rendersFullHTMLDocument() async throws {
    let html = HTML {
        Head {
            H1 {
                "Ignored for now"
            }
        }
        
        Body {
            H1 {
                "Hello"
            }
            
            P {
                "World"
            }
        }
    }
    
    #expect(html.render() == "<html><head><h1>Ignored for now</h1></head><body><h1>Hello</h1><p>World</p></body></html>")
}

@Test
func rendersInlineElements() async throws {
    let p = P {
        "Hello "
        Span {
            "Swift"
        }
        " world"
    }
    
    #expect(p.render() == "<p>Hello <span>Swift</span> world</p>")
}

@Test
func rendersHeadings() async throws {
    let html = Div {
        H1 { "Heading 1" }
        H2 { "Heading 2" }
        H3 { "Heading 3" }
    }
    
    #expect(html.render() == "<div><h1>Heading 1</h1><h2>Heading 2</h2><h3>Heading 3</h3></div>")
}

@Test
func rendersAnchorWithHref() async throws {
    let a = A(href: "https://example.com?foo=bar&baz=qux") {
        "Example"
    }
    
    #expect(
        a.render() == "<a href=\"https://example.com?foo=bar&amp;baz=qux\">Example</a>"
    )
}

@Test
func rendersEmptyContainerElement() async throws {
    let div = Div {}
    
    #expect(div.render() == "<div></div>")
}
