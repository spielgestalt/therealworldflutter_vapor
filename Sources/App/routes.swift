import Crypto
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // public routes
    let userController = UserController()
    router.post("users", use: userController.create)
    
    // basic / password auth protected routes
    let basic = router.grouped(User.basicAuthMiddleware(using: BCryptDigest()))
    basic.post("api/login", use: userController.login)

    let pageController = PageController()
    try router.register(collection: pageController)
    let contentController = ContentController()
    try router.register(collection: contentController)
    // bearer / token auth protected routes
    //let bearer = router.grouped(User.tokenAuthMiddleware())
    /*let todoController = TodoController()
    bearer.get("todos", use: todoController.index)
    bearer.post("todos", use: todoController.create)
    bearer.delete("todos", Todo.parameter, use: todoController.delete)
 */
}
