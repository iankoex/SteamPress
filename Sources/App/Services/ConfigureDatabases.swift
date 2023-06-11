import Vapor
import Fluent
import FluentPostgresDriver

extension Services {
    static func configureDatabases(_ app: Application) throws {
        if app.environment == .development {
            //        if let databaseURL = Environment.get("DATABASE_URL_DEV"), let postgresConfig = PostgresConfiguration(url: databaseURL) {
            //            app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
            //        }
            app.databases.use(.postgres(
                hostname: Environment.get("DATABASE_HOST") ?? "localhost",
                port: 5432,
                username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
                password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
                database: Environment.get("DATABASE_NAME") ?? "vapor_database"
            ), as: .psql)
        } else if app.environment == .production {
            if let databaseURL = Environment.get("DATABASE_URL"), let postgresConfig = PostgresConfiguration(url: databaseURL) {
                app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
            }
        }
    }
}
