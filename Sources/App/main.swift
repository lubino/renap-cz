import Vapor
//import VaporPostgreSQL
import Mustache

let drop = Droplet(
//    providers: [VaporPostgreSQL.Provider.self]
)

drop.get("version") { request in
//  if let db = drop.database?.driver as? PostgreSQLDriver {
//   let version = try db.raw("SELECT version()")
//    return try JSON(node: version)
//  } else {
    return "No db connection"
//  }
}

drop.get("hello") { req in
    return "Hello, world."
}

drop.get { req in
    let data: [String: Any] = [
        "name": "Arthur",
        "late": true
    ]
    let template = try Template(string: "Hello {{name}}")
    return template.render(data)
}

drop.run()
