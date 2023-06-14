import Vapor
import Fluent
import FluentPostgresDriver
import FluentSQL
import SteamPressCore

extension Services {
    static func configureDatabases(_ app: Application) throws {
        guard let dbClient = Environment.get("DATABASE_CLIENT") else {
            throw SteamPressError(identifier: "SteamPressError", "DATABASE_CLIENT not set. Options: `psql` or `mysql`")
        }
        if dbClient == "psql" {
            try configurePostgres(app)
        } else if dbClient == "mysql" {
            try configureMySQL(app)
        } else {
            throw SteamPressError(identifier: "SteamPressError", "Unknown value provided for DATABASE_CLIENT. Options: `psql` or `mysql`")
        }
    }
    
    fileprivate  static func configurePostgres(_ app: Application) throws {
//        if app.environment == .development {
//            app.databases.use(.postgres(
//                hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//                port: 5432,
//                username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//                password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//                database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//            ), as: .psql)
//        } else if app.environment == .production {
            if let databaseURL = Environment.get("DATABASE_URL") {
                try app.databases.use(.postgres(url: databaseURL), as: .psql)
            }
//        }
    }
    
    fileprivate  static func configureMySQL(_ app: Application) throws {
        throw SteamPressError(identifier: "SteamPressError", "`mysql` database not currently supported. Use `psql` for now.")
    }
}
