import Fluent
import Vapor
import SteamPressCore

struct FluentPostRepository: BlogPostRepository {
    var req: Request
    
    init(_ req: Request) {
        self.req = req
    }
    
    func `for`(_ request: Vapor.Request) -> BlogPostRepository {
        return self
    }
    
    func getAllPostsSortedByPublishDate(includeDrafts: Bool) async throws -> [BlogPost] {
        let query = BlogPost.query(on: req.db)
            .sort(\.$created, .descending)
            .with(\.$author)
            .with(\.$tags)
        if !includeDrafts {
            query.filter(\.$published == true)
        }
        return try await query.all()
    }
    
    func getAllDraftsPostsSortedByPublishDate() async throws -> [BlogPost] {
        let query = BlogPost.query(on: req.db)
            .sort(\.$created, .descending)
            .with(\.$author)
            .with(\.$tags)
            .filter(\.$published == false)
        return try await query.all()
    }
    
    func getAllPostsSortedByPublishDate(includeDrafts: Bool, count: Int, offset: Int) async throws -> [BlogPost] {
        let query = BlogPost.query(on: req.db)
            .sort(\.$created, .descending)
            .with(\.$author)
            .with(\.$tags)
        if !includeDrafts {
            query.filter(\.$published == true)
        }
        let upperLimit = count + offset
        return try await query.range(offset..<upperLimit).all()
    }
    
    func getAllPostsCount(includeDrafts: Bool) async throws -> Int {
        let query = BlogPost.query(on: req.db)
        if !includeDrafts {
            query.filter(\.$published == true)
        }
        return try await query.count()
    }
    
    func getAllPostsSortedByPublishDate(for user: BlogUser, includeDrafts: Bool, count: Int, offset: Int) async throws -> [BlogPost] {
        let query = user.$posts.query(on: req.db)
            .sort(\.$created, .descending)
            .with(\.$author)
            .with(\.$tags)
        if !includeDrafts {
            query.filter(\.$published == true)
        }
        let upperLimit = count + offset
        return try await query.range(offset..<upperLimit).all()
    }
    
    func getPostCount(for user: BlogUser) async throws -> Int {
        try await user.$posts.query(on: req.db)
            .filter(\.$published == true)
            .count()
    }
    
    func getPost(slug: String) async throws -> BlogPost? {
        try await BlogPost.query(on: req.db)
            .filter(\.$slugURL == slug)
            .with(\.$author)
            .with(\.$tags)
            .first()
    }
    
    func getPost(id: UUID) async throws -> BlogPost? {
        try await BlogPost.query(on: req.db)
            .filter(\.$id == id)
            .with(\.$author)
            .with(\.$tags)
            .first()
    }
    
    func getSortedPublishedPosts(for tag: BlogTag, count: Int, offset: Int) async throws -> [BlogPost] {
        let query = tag.$posts.query(on: req.db)
            .filter(\.$published == true)
            .sort(\.$created, .descending)
            .with(\.$author)
            .with(\.$tags)
        let upperLimit = count + offset
        return try await query.range(offset..<upperLimit).all()
    }
    
    func getPublishedPostCount(for tag: BlogTag) async throws -> Int {
        try await tag.$posts.query(on: req.db)
            .filter(\.$published == true)
            .count()
    }
    
    func findPublishedPostsOrdered(for searchTerm: String, count: Int, offset: Int) async throws -> [BlogPost] {
        let query = BlogPost.query(on: req.db)
            .sort(\.$created, .descending)
            .filter(\.$published == true)
            .with(\.$author)
            .with(\.$tags)
        
        let upperLimit = count + offset
        let paginatedQuery = query.range(offset..<upperLimit)
        
        return try await paginatedQuery.group(.or) { or in
            or.filter(\.$title, .custom("ILIKE"), "%\(searchTerm)%")
            or.filter(\.$contents, .custom("ILIKE"), "%\(searchTerm)%")
        }.all()
    }
    
    func getPublishedPostCount(for searchTerm: String) async throws -> Int {
        try await BlogPost.query(on: req.db)
            .filter(\.$published == true).group(.or) { or in
                or.filter(\.$title, .custom("ILIKE"), "%\(searchTerm)%")
                or.filter(\.$contents, .custom("ILIKE"), "%\(searchTerm)%")
            }
            .count()
    }
    
    func save(_ post: BlogPost) async throws {
        try await post.save(on: req.db)
    }
    
    func delete(_ post: BlogPost) async throws {
        try await post.delete(on: req.db)
    }
}

