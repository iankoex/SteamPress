import Vapor
import Fluent
import FluentPostgresDriver
import FluentMySQLDriver
import FluentSQLiteDriver
import SteamPressCore

extension Services {
    static func configureDatabases(_ app: Application) throws {
        guard let dbClient = Environment.get("DATABASE_CLIENT") else {
            throw SteamPressError(identifier: "SteamPressError", "DATABASE_CLIENT not set. Options: `psql`, `sqlite` or `mysql`")
        }
        if dbClient == "psql" {
            try configurePostgres(app)
        } else if dbClient == "mysql" {
            try configureMySQL(app)
        } else if dbClient == "sqlite" {
            try configureSqlite(app)
        } else {
            throw SteamPressError(identifier: "SteamPressError", "Unknown value provided for DATABASE_CLIENT. Options: `psql`, `sqlite` or `mysql`")
        }
    }
    
    fileprivate static func configurePostgres(_ app: Application) throws {
//        if let databaseURL = Environment.get("DATABASE_URL") {
//            try app.databases.use(.postgres(url: databaseURL), as: .psql)
//        }
        if app.environment == .development {
            app.databases.use(.postgres(
                hostname: Environment.get("DATABASE_HOST") ?? "localhost",
                port: 5432,
                username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
                password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
                database: Environment.get("DATABASE_NAME") ?? "vapor_database"
            ), as: .psql)
        } else if app.environment == .production {
            if let databaseURL = Environment.get("DATABASE_URL") {
                try app.databases.use(.postgres(url: databaseURL), as: .psql)
            }
        }
    }
    
    fileprivate static func configureMySQL(_ app: Application) throws {
        throw SteamPressError(identifier: "SteamPressError", "`mysql` database not currently supported. Use `psql` for now.")
    }
    
    fileprivate static func configureSqlite(_ app: Application) throws {
        if app.environment == .testing {
            app.databases.use(.sqlite(.memory), as: .sqlite, isDefault: true)
        } else {
            app.databases.use(.sqlite(.file("Resources/db.sqlite")), as: .sqlite)
        }
    }
}
