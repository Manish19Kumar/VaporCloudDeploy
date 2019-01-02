// import FluentSQLite
// import FluentMySQL
import FluentPostgreSQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    /*try services.register(FluentMySQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
 */
    try services.register(FluentPostgreSQLProvider())
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    /*let sqlite = try SQLiteDatabase(storage: .memory)

    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)
 
    
    // 1. Register the FluentSQLiteProvider as a service to allow the application to interact with SQLite via Fluent.
    try services.register(FluentMySQLProvider())

    // If you want persistent storage with SQLite, provide SQLiteDatabase with a path:
    /// let database = SQLiteDatabase(storage: .file(path: "db.sqlite"))
    /// try databases.add(database: database), as: .sqlite)
    
    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Acronym.self, database: .sqlite)
    services.register(migrations)
 */
    // var databases = DatabasesConfig()
    /*let databaseConfig = MySQLDatabaseConfig(
        hostname: "localhost",
        username: "vapor",
        password: "password",
        database: "vapor")
    let database = MySQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .mysql)
    services.register(databases)
    var migrations = MigrationConfig()
    // 4
    migrations.add(model: Acronym.self, database: .mysql)
    services.register(migrations)
 */
    
    // 3
    /*let databaseConfig = PostgreSQLDatabaseConfig(
        hostname: "localhost",
          port: 5432,
        username: "vapor",
        database: "vapor",
        password: "password")
    let database = PostgreSQLDatabase(config: databaseConfig)
    databases.add(database: database, as: .psql)
    services.register(databases)
    var migrations = MigrationConfig()
    // 4
    migrations.add(model: Acronym.self, database: .psql)
    services.register(migrations)
 */
    
    // 1. Create a DatabasesConfig to configure the database.
    var databases = DatabasesConfig()
    // 2. Use Environment.get(_:) to fetch environment variables set by Vapor Cloud. If the function call returns nil (i.e. the application is running locally), default to the values required for the Docker container.
    let hostname = Environment.get("DATABASE_HOSTNAME")
        ?? "localhost"
    let username = Environment.get("DATABASE_USER") ?? "vapor"
    let databaseName = Environment.get("DATABASE_DB") ?? "vapor"
    let password = Environment.get("DATABASE_PASSWORD")
        ?? "password"
    // 3. Use the properties to create a new PostgreSQLDatabaseConfig.
    let databaseConfig = PostgreSQLDatabaseConfig(
        hostname: hostname,
        username: username,
        database: databaseName,
        password: password)
    // 4. Create a PostgreSQLDatabase using the configuration.
    let database = PostgreSQLDatabase(config: databaseConfig)
    // 5. Add the database object to the DatabasesConfig using the default .psql identifier.
    databases.add(database: database, as: .psql)
    // 6. Register DatabasesConfig with the services.
    services.register(databases)
    
    var migrations = MigrationConfig()
    // 4
    migrations.add(model: Acronym.self, database: .psql)
    services.register(migrations)
}
