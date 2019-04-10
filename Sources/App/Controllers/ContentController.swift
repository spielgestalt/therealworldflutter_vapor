//
//  ContentController.swift
//  App
//
//  Created by Carsten Fregin on 10.04.19.
//

import Vapor

struct ContentController: RouteCollection {
    func boot(router: Router) throws {
        let pageContentRoute = router.grouped(User.tokenAuthMiddleware()).grouped("api", "pages").grouped(Page.parameter).grouped("contents")
        let contentRoute = router.grouped(User.tokenAuthMiddleware()).grouped("api", "contents")

        pageContentRoute.get( use: getAllHandler)
        contentRoute.get( ContentElement.parameter, use: getOneHandler)
        contentRoute.post(use: createHandler)
        contentRoute.put(ContentElement.parameter, use: updateHandler)
        contentRoute.delete(ContentElement.parameter, use: deleteHandler)
    }
    func createHandler(_ req: Request) throws -> Future<ContentElement> {
        _ = try req.requireAuthenticated(User.self)
        return try req
            .content
            .decode(ContentElement.self)
            .flatMap { (user) in
                return user.save(on: req)
        }
    }

    func getAllHandler(_ req: Request) throws -> Future<[ContentElement]> {
        _ = try req.requireAuthenticated(User.self)

        return try req.parameters.next(Page.self).flatMap(to: [ContentElement].self) { page in
            try page.contentElements.query(on: req).all()
        }
        //return ContentElement.query(on: req).decode(ContentElement.self).all()
    }

    func getOneHandler(_ req: Request) throws -> Future<ContentElement> {
        _ = try req.requireAuthenticated(User.self)
        return try req.parameters.next(ContentElement.self)
    }

    func updateHandler(_ req: Request) throws -> Future<ContentElement> {
        _ = try req.requireAuthenticated(User.self)
        return try flatMap(to: ContentElement.self, req.parameters.next(ContentElement.self), req.content.decode(ContentElement.self)){ (contentElement, updatedContentElement) in
            var contentElement = contentElement
            contentElement.textContent = updatedContentElement.textContent
            return contentElement.save(on: req)
        }
    }

    func deleteHandler(_ req:Request) throws -> Future<HTTPStatus> {
        _ = try req.requireAuthenticated(User.self)
        return try req.parameters.next(ContentElement.self).flatMap { (user) in
            return user.delete(on: req).transform(to: HTTPStatus.noContent)
        }
    }


}
