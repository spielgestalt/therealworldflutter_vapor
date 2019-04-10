//
//  Content.swift
//  App
//
//  Created by Carsten Fregin on 10.04.19.
//

import Vapor
import FluentPostgreSQL

struct ContentElement {
    var id: UUID?
    var textContent: String
    var pageId: Page.ID
}
extension ContentElement {
    var page: Parent<ContentElement, Page> {
        return parent(\.pageId)
    }
}
extension ContentElement: PostgreSQLUUIDModel {}
extension ContentElement: Content {}
extension ContentElement: Migration {
    static func prepare(on conn: PostgreSQLConnection) -> Future<Void> {
        return PostgreSQLDatabase.create(ContentElement.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.textContent)
            builder.field(for: \.pageId)
            builder.reference(from: \.pageId, to: \Page.id)
            //builder.reference(from: \.userID, to: \User.id)
        }
    }
}
extension ContentElement: Parameter {}
