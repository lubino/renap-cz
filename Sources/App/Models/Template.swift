import Vapor
import Foundation

final class Template: Model{
    var id: Node?
    var exists: Bool = false
    
    var name: String
    var contentType: String?
    var data: String
    
    init(name: String, contentType: String? = nil, data: String) {
        self.id = nil
        self.name = name
        self.contentType = contentType
        self.data = data
    }
    
    init (node :Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        contentType = try node.extract("contentType")
        data = try node.extract("data")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "contentType": contentType,
            "data": data
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("templates") { users in
            users.id()
            users.string("name")
            users.string("contentType")
            users.string("data")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("templates")
    }
}

extension Template {
    func pages() throws -> [Page] {
        return try children("templateId", Page.self).all()
    }
}
