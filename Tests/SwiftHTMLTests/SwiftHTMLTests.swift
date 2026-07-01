import Testing
@testable import SwiftHTML

@Test
func rendersTextEscaped() async throws {
    let textNode = TextNode("Hello <Swift> & \"HTML\"")
    
    #expect(textNode.render() == "Hello &lt;Swift&gt; &amp; &quot;HTML&quot;")
}

@Test
func rendersStringChildrenEscaped() async throws {
    let div = Div {
        "\"quoted\""
    }

    #expect(div.render() == "<div>&quot;quoted&quot;</div>")
}

@Test
func rendersRawTextUnescaped() async throws {
    let script = Script(Attribute("type", "application/ld+json")) {
        RawText("""
        {"@context":"https://schema.org"}
        """)
    }

    #expect(script.render() == "<script type=\"application/ld+json\">{\"@context\":\"https://schema.org\"}</script>")
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
func rendersCompactElementsWhenPrettyPrintingIsDisabled() async throws {
    let div = Div {
        H1 { "Title" }
        P { "Text" }
    }
    
    #expect(div.render(prettyPrinted: false) == "<div><h1>Title</h1><p>Text</p></div>")
}

@Test
func rendersPrettyPrintedElements() async throws {
    let div = Div {
        H1 { "Title" }
        P { "Text" }
    }
    
    #expect(
        div.render(prettyPrinted: true) ==
        """
        <div>
            <h1>Title</h1>
            <p>Text</p>
        </div>
        """
    )
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
func rendersMixedInlineContentCompactWhenPrettyPrinted() async throws {
    let p = P {
        "Hello "
        Span {
            "Swift"
        }
        " world"
    }
    
    #expect(p.render(prettyPrinted: true) == "<p>Hello <span>Swift</span> world</p>")
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
    let a = A(.href("https://example.com?foo=bar&baz=qux")) {
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

@Test
func preservesAttributeInsertionOrder() async throws {
    let div = Div(.id("hero"), .class("featured"), .ariaLabel("Intro")) {}
    
    #expect(div.render() == "<div id=\"hero\" class=\"featured\" aria-label=\"Intro\"></div>")
}

@Test
func escapesAttributeValues() async throws {
    let a = A(.href("https://example.com?name=<Swift>&quote=\"yes\"")) {
        "Example"
    }
    
    #expect(
        a.render() == "<a href=\"https://example.com?name=&lt;Swift&gt;&amp;quote=&quot;yes&quot;\">Example</a>"
    )
}

@Test
func rendersHTMLLangAttribute() async throws {
    let html = HTML(.lang("en")) {}
    
    #expect(html.render() == "<html lang=\"en\"></html>")
}

@Test
func rendersMetaCharsetAsVoidElement() async throws {
    let meta = Meta(.charset("UTF-8"))
    
    #expect(meta.render() == "<meta charset=\"UTF-8\">")
}

@Test
func rendersLinkStylesheetAsVoidElement() async throws {
    let link = Link(.rel("stylesheet"), .href("style.css"))
    
    #expect(link.render() == "<link rel=\"stylesheet\" href=\"style.css\">")
}

@Test
func rendersImgWithSource() async throws {
    let img = Img(.src("assets/profile1.jpeg"))

    #expect(img.render() == "<img src=\"assets/profile1.jpeg\">")
}

@Test
func rendersImgWithSourceAndAlt() async throws {
    let img = Img(
        .src("assets/profile1.jpeg"),
        .alt("Damian Van de Kauter")
    )

    #expect(img.render() == "<img src=\"assets/profile1.jpeg\" alt=\"Damian Van de Kauter\">")
}

@Test
func rendersImgWithSourceAltAndClass() async throws {
    let img = Img(
        .src("assets/profile1.jpeg"),
        .alt("Damian Van de Kauter"),
        .class("profile-image")
    )

    #expect(
        img.render() ==
            "<img src=\"assets/profile1.jpeg\" alt=\"Damian Van de Kauter\" class=\"profile-image\">"
    )
}

@Test
func prettyPrintsImgWithoutClosingTag() async throws {
    let img = Img(.src("assets/profile1.jpeg"))
    let rendered = img.render(prettyPrinted: true)

    #expect(rendered == "<img src=\"assets/profile1.jpeg\">")
    #expect(!rendered.contains("</img>"))
}

@Test
func rendersScriptWithSourceAndDeferAttribute() async throws {
    let script = Script(.src("app.js"), .defer)

    #expect(script.render() == "<script src=\"app.js\" defer=\"\"></script>")
}

@Test
func rendersSemanticBodyElements() async throws {
    let main = Main {
        Section(.class("hero")) {
            Article(.class("card")) {
                H2 { "Backend" }
                P { "Server-side Swift." }
            }
        }
    }
    
    #expect(
        main.render() == "<main><section class=\"hero\"><article class=\"card\"><h2>Backend</h2><p>Server-side Swift.</p></article></section></main>"
    )
}

@Test
func rendersFormElementWithAttributes() async throws {
    let form = Form(.class("contact-form"), Attribute("method", "post")) {}

    #expect(form.render() == "<form class=\"contact-form\" method=\"post\"></form>")
}

@Test
func rendersLabelElementWithAttributes() async throws {
    let label = Label(Attribute("for", "name")) {
        "Naam"
    }

    #expect(label.render() == "<label for=\"name\">Naam</label>")
}

@Test
func rendersInputAsVoidElementWithAttributes() async throws {
    let input = Input(Attribute("type", "text"), .id("name"))
    let rendered = input.render()

    #expect(rendered == "<input type=\"text\" id=\"name\">")
    #expect(!rendered.contains("</input>"))
}

@Test
func rendersTextAreaAsContainerElementWithAttributes() async throws {
    let textArea = TextArea(.id("message")) {
        ""
    }
    let rendered = textArea.render()

    #expect(rendered == "<textarea id=\"message\"></textarea>")
    #expect(rendered.contains("</textarea>"))
}

@Test
func rendersFooterElementWithAttributes() async throws {
    let footer = Footer(.class("site-footer")) {
        P { "© Damian Van de Kauter" }
    }

    #expect(footer.render() == "<footer class=\"site-footer\"><p>© Damian Van de Kauter</p></footer>")
}

@Test
func rendersNestedFormContent() async throws {
    let form = Form(.class("contact-form"), Attribute("method", "post")) {
        Input(Attribute("type", "text"))
        Label(Attribute("for", "name")) { "Naam" }
        TextArea(.id("message")) { "" }
    }

    #expect(
        form.render() ==
            "<form class=\"contact-form\" method=\"post\"><input type=\"text\"><label for=\"name\">Naam</label><textarea id=\"message\"></textarea></form>"
    )
}

@Test
func rendersHTMLDocumentWithDoctype() async throws {
    let document = HTMLDocument {
        HTML(.lang("en")) {
            Head {
                Title {
                    "Damian Van de Kauter"
                }
            }
            Body {}
        }
    }
    
    #expect(
        document.render(prettyPrinted: true) ==
        """
        <!DOCTYPE html>
        <html lang="en">
            <head>
                <title>Damian Van de Kauter</title>
            </head>
            <body></body>
        </html>
        """
    )
}
