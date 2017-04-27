import Vapor

final class Web: Model{
    var id: Node?
    var exists: Bool = false
    
    var host: String
    var contextPath: String
    var name: String

    init(name: String, host: String, contextPath: String) {
        self.id = nil
        self.contextPath = contextPath
        self.name = name
        self.host = host
    }
    
    init (node :Node, in context: Context) throws {
        id = try node.extract("id")
        host = try node.extract("host")
        contextPath = try node.extract("contextPath")
        name = try node.extract("name")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "host": host,
            "contextPath": contextPath,
            "name": name
        ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("web") { users in
            users.id()
            users.string("host")
            users.string("contextPath")
            users.string("name")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("web")
    }
}
