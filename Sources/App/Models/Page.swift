import Vapor
import Foundation

final class Page: Model{
    var id: Node?
    var exists: Bool = false
    var parentId: Node?
    var templateId: Node?
    
    var name: String
    var urlPath: String
    var data: String
    var createdAt: Date
    var updatedAt: Date
    
    init(name: String, urlPath: String, data: String, parentPageId: Node? = nil, templateId: Node? = nil) {
        self.id = nil
        self.parentId = parentPageId
        self.templateId = templateId
        self.name = name
        self.data = data
        self.urlPath = urlPath
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    init (node :Node, in context: Context) throws {
        id = try node.extract("id")
        parentId = try node.extract("parentId")
        templateId = try node.extract("templateId")
        name = try node.extract("name")
        urlPath = try node.extract("urlPath")
        data = try node.extract("data")
        createdAt = try Date(timeIntervalSince1970: node.extract("createdAt"))
        updatedAt = try Date(timeIntervalSince1970: node.extract("updatedAt"))
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "parentId": parentId,
            "templateId": templateId,
            "name": name,
            "data": data,
            "urlPath": urlPath,
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970
        ])
    }
    
    static func prepare(_ database: Database) throws {
    }
    
    static func revert(_ database: Database) throws {
    }
}

extension Page {
    func pages() throws -> [Page] {
        return try children("parentId", Page.self).all()
    }
    
    func parentPage() throws -> Page? {
        return try parent(parentId, "parentId", Page.self).get()
    }
    
    func template() throws -> Template? {
        return try parent(templateId, "templateId", Template.self).get()
    }
}
