//
//  Page.swift
//  App
//
//  Created by Carsten Fregin on 10.04.19.
//

import Vapor
import FluentPostgreSQL

struct Page {
    var id: UUID?
    var title: String
    var parentId: Page.ID?
}

extension Page {
    var pages: Children<Page, Page> {

        return self.children(\.parentId)
    }
    var parent: Parent<Page, Page>? {
        return self.parent(\.parentId)
    }
    var contentElements: Children<Page, ContentElement> {
        return children(\.pageId)
    }
}

extension Page: PostgreSQLUUIDModel {}
extension Page: Content {}
extension Page: Migration {
    static func prepare(on conn: PostgreSQLConnection) -> Future<Void> {
        return PostgreSQLDatabase.create(Page.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.title)
            builder.field(for: \.parentId)
            builder.reference(from: \.parentId, to: \Page.id)
        }
    }
}
extension Page: Parameter {}
