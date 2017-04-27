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
    let data: [String: Any] = [
        "name": "Arthur",
        "late": true
    ]
    //let template = try Template(string: "Hello {{name}}")
    //return template.render(data)
    let postgreSQL =  PostgreSQL.Database(
        host: "ec2-54-247-189-141.eu-west-1.compute.amazonaws.com",
        dbname: "d45b0fv9ofti1j",
        user: "samyfioimiutbn",
        password: "d6f9b26890479397b198fe278dbd34bc2dca6f05c105dd07caee7fd40a0bb4fb"
    )
    
    let results = try postgreSQL.execute("SELECT * FROM web Order By name", [])
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

drop.run()
