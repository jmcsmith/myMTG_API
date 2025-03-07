import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.http.server.configuration.responseCompression = .enabled
    app.routes.defaultMaxBodySize = 1073741824
    
    var tls1 = TLSConfiguration.makeClientConfiguration()
    tls1.certificateVerification = .none
    
    app.databases.use(DatabaseConfigurationFactory.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "192.168.97.2",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tlsConfiguration: tls1
    ), as: .mysql)

    app.migrations.add(CreateUpdateSet())
    app.migrations.add(CreateUpdateCard())
    app.migrations.add(CreateUpdateToken())
    
    try await app.autoMigrate()
    // register routes
    try routes(app)
}
