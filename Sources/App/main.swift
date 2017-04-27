import Vapor
import VaporPostgreSQL
import PostgreSQL
//import Mustache
//import VaporMustache

let drop = Droplet(
//    providers: [VaporPostgreSQL.Provider.self]
)

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

drop.get("t") { req in
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let results = try db.execute("SELECT * FROM web Order By name")
        var result = ""
        for row in results {
            for column in row {
                let key = column.key
                let value = column.value.string
                result = "\(result), \(key):\(value!)"
            }
        }
        
        return result;
    }

    let data: [String: Any] = [
        "name": "Arthur",
        "late": true
    ]
    //let template = try Template(string: "Hello {{name}}")
    //return template.render(data)
    return "No db connection"
    
}

drop.run()
