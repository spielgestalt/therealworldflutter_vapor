//
//  PageController.swift
//  App
//
//  Created by Carsten Fregin on 10.04.19.
//

import Vapor
import  Pagination

struct PageController: RouteCollection {
    func boot(router: Router) throws {
        let pageRoute = router.grouped(User.tokenAuthMiddleware()).grouped("api", "pages")
        pageRoute.get(use: getAllHandler)
        pageRoute.get(Page.parameter, use: getOneHandler)
        pageRoute.post(use: createHandler)
        pageRoute.put(Page.parameter, use: updateHandler)
        pageRoute.delete(Page.parameter, use: deleteHandler)
    }
    func createHandler(_ req: Request) throws -> Future<Page> {
        _ = try req.requireAuthenticated(User.self)
        return try req
            .content
            .decode(Page.self)
            .flatMap { (page) in
                return page.save(on: req)
            }
    }

    func getAllHandler(_ req: Request) throws -> Future<Paginated<Page>> {
        _ = try req.requireAuthenticated(User.self)
        return try Page.query(on: req).paginate(for: req)
        /*return Page.query(on: req).decode(Page.self).all().map{ pages in
            return pages
        }*/
    }

    func getOneHandler(_ req: Request) throws -> Future<Page> {
        _ = try req.requireAuthenticated(User.self)
        return try req.parameters.next(Page.self)
    }

    func updateHandler(_ req: Request) throws -> Future<Page> {
        _ = try req.requireAuthenticated(User.self)
        return try flatMap(to: Page.self, req.parameters.next(Page.self), req.content.decode(Page.self)){ (page, updatedPage) in
            var page = page
            page.title = updatedPage.title
            return page.save(on: req)
        }
    }

    func deleteHandler(_ req:Request) throws -> Future<HTTPStatus> {
        _ = try req.requireAuthenticated(User.self)
        return try req.parameters.next(Page.self).flatMap { (user) in
            return user.delete(on: req).transform(to: HTTPStatus.noContent)
        }
    }
}
