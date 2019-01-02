// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "TILAPPVAPORDEPLOYED",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 1. Specify FluentMySQL as a package dependency.
        // .package(url: "https://github.com/vapor/fluent-mysql.git",
                // from: "3.0.0-rc")
        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        //.package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0")
        // 1. Specify FluentPostgreSQL as a package dependency.
        .package(
        url: "https://github.com/vapor/fluent-postgresql.git",
        from: "1.0.0-rc")
        
    ],
    targets: [
        /// Using sqlite
        // .target(name: "App", dependencies: ["FluentSQLite", "Vapor"]),
        // Using MySQL
        // 1. Specify FluentMySQL as a package dependency.
        // .target(name: "App", dependencies: ["FluentMySQL",
         //                                   "Vapor"]),
        // 2. Specify that the App target depends on FluentPostgreSQL to ensure it links correctly.
        .target(name: "App", dependencies: ["FluentPostgreSQL",
                                            "Vapor"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

