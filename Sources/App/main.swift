import Vapor
import VaporPostgreSQL

let drop = Droplet()

drop.preparations += Web.self
drop.preparations += Page.self
drop.preparations += Template.self

try drop.addProvider(VaporPostgreSQL.Provider)

drop.get("version") { request in
  if let db = drop.database?.driver as? PostgreSQLDriver {
   let version = try db.raw("SELECT version()")
    return try JSON(node: version)
  } else {
    return "No db connection"
  }
}

drop.get("hello") { req in
    return "Hello, world."
}

drop.get("web") { req in
    return try JSON(node: Web.all().makeNode())
}

drop.get("page") { req in
    return try JSON(node: Page.all().makeNode())
}

drop.get("template") { req in
    return try JSON(node: Template.all().makeNode())
}

drop.run()
