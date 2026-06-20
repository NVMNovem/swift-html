//
//  Attribute.swift
//  swift-html
//
//  Created by Damian Van de Kauter on 06/06/2026.
//

public struct Attribute: Sendable {

    public let key: String
    public let value: String

    public init(
        _ key: String,
        _ value: String
    ) {
        self.key = key
        self.value = value
    }
}

public extension Attribute {

    static func `class`(_ value: String) -> Self {
        .init("class", value)
    }

    static func id(_ value: String) -> Self {
        .init("id", value)
    }

    static func href(_ value: String) -> Self {
        .init("href", value)
    }

    static func src(_ value: String) -> Self {
        .init("src", value)
    }

    static func alt(_ value: String) -> Self {
        .init("alt", value)
    }

    static var `defer`: Self {
        .init("defer", "")
    }

    static func lang(_ value: String) -> Self {
        .init("lang", value)
    }

    static func rel(_ value: String) -> Self {
        .init("rel", value)
    }

    static func charset(_ value: String) -> Self {
        .init("charset", value)
    }

    static func name(_ value: String) -> Self {
        .init("name", value)
    }

    static func content(_ value: String) -> Self {
        .init("content", value)
    }

    static func ariaLabel(_ value: String) -> Self {
        .init("aria-label", value)
    }

    static func ariaLabelledBy(_ value: String) -> Self {
        .init("aria-labelledby", value)
    }
}
