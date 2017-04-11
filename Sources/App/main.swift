import Vapor

let drop = Droplet()

drop.get("hello") { req in
    return "Hello, world."
}

drop.get("") { req in
    return "Hello, world"
}

drop.run()
