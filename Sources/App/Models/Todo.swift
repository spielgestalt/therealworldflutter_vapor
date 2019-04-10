/*import FluentPostgreSQL
import Vapor

/// A single entry of a todo list.
final class Todo: PostgreSQLUUIDModel {
    /// The unique identifier for this `Todo`.
    var id: UUID?

    /// A title describing what this `Todo` entails.
    var title: String
    
    /// Reference to user that owns this TODO.
    var userID: User.ID

    /// Creates a new `Todo`.
    init(id: UUID? = nil, title: String, userID: User.ID) {
        self.id = id
        self.title = title
        self.userID = userID
    }
}

extension Todo {
    /// Fluent relation to user that owns this todo.
    var user: Parent<Todo, User> {
        return parent(\.userID)
    }
}

/// Allows `Todo` to be used as a Fluent migration.
extension Todo: Migration {
    static func prepare(on conn: PostgreSQLConnection) -> Future<Void> {
        return PostgreSQLDatabase.create(Todo.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.title)
            builder.field(for: \.userID)
            builder.reference(from: \.userID, to: \User.id)
        }
    }
}

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Todo: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Todo: Parameter { }
*/
