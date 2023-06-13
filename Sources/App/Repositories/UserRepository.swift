import Fluent
import Vapor
import SteamPressCore

struct FluentUserRepository: BlogUserRepository {
    
    var req: Request
    
    init(_ req: Request) {
        self.req = req
    }
    
    func `for`(_ request: Vapor.Request) -> BlogUserRepository {
        return self
    }
    
    func getAllUsers() async throws -> [BlogUser] {
        try await BlogUser.query(on: req.db).all()
    }
    
    func getAllUsersWithPostCount() async throws -> [(BlogUser, Int)] {
        let users = try await BlogUser.query(on: req.db)
            .all()
        var result: [(BlogUser, Int)] = []
        for user in users {
            let count = try await user.$posts.query(on: req.db).count()
            result.append((user, count))
        }
        return result
    }
    
    func getUser(id: UUID) async throws -> BlogUser? {
        try await BlogUser.query(on: req.db)
            .filter(\.$id == id)
            .first()
    }
    
    func getUser(name: String) async throws -> BlogUser? {
        try await BlogUser.query(on: req.db)
            .filter(\.$name == name)
            .first()
    }
    
    func getUser(username: String) async throws -> BlogUser? {
        try await BlogUser.query(on: req.db)
            .filter(\.$username == username)
            .first()
    }
    
    func getUser(email: String) async throws -> BlogUser? {
        try await BlogUser.query(on: req.db)
            .filter(\.$email == email)
            .first()
    }
    
    func save(_ user: BlogUser) async throws {
        try await user.save(on: req.db)
    }
    
    func delete(_ user: BlogUser) async throws {
        try await user.delete(on: req.db)
    }
    
    func getUsersCount() async throws -> Int {
        try await BlogUser.query(on: req.db).count()
    }
}
