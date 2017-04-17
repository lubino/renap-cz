import PackageDescription

let package = Package(
    name: "renap-cz",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 5),
        //.Package(url: "https://github.com/vapor/postgresql-provider", majorVersion: 1, minor: 0),
        //.Package(url: "https://github.com/qutheory/vapor-mustache.git", majorVersion: 0, minor: 8),
        //.Package(url: "https://github.com/groue/GRMustache.swift", majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/Zewo/Mustache.git", majorVersion: 0, minor: 5),
    ],
    exclude: [
        //"Config",
        //"Database",
        //"Localization",
        //"Public",
        //"Resources",
    ]
)

