import Fluent
import Vapor
import SteamPressCore

struct FluentTagRepository: BlogTagRepository {
    
    var req: Request
    
    init(_ req: Request) {
        self.req = req
    }
    
    func `for`(_ request: Vapor.Request) -> BlogTagRepository {
        return self
    }
    
    func getAllTags() async throws -> [BlogTag] {
        let tags = try await BlogTag.query(on: req.db)
            .with(\.$posts)
            .sort(\.$createdDate, .descending)
            .all()
        return tags
    }
    
    func getAllTagsWithPostCount() async throws -> [(BlogTag, Int)] {
        let tags = try await BlogTag.query(on: req.db)
            .with(\.$posts)
            .all()
        var result: [(BlogTag, Int)] = []
        for tag in tags {
            let postCount = try await tag.$posts.get(on: req.db).count
            result.append((tag, postCount))
        }
        return result
    }
    
    func getTagsForAllPosts() async throws -> [UUID : [BlogTag]] {
        let tags = try await BlogTag.query(on: req.db)
            .with(\.$posts)
            .all()
        let pivots = try await PostTagPivot.query(on: req.db).all()
        let pivotsSortedByPost = Dictionary(grouping: pivots) { (pivot) -> UUID in
            return pivot.$post.id
        }

        let postsWithTags = pivotsSortedByPost.mapValues { value in
            return value.map { pivot in
                tags.first { $0.id == pivot.$tag.id }
            }
        }.mapValues { $0.compactMap { $0 } }

        return postsWithTags
    }
    
    func getTags(for post: BlogPost) async throws -> [BlogTag] {
        try await post.$tags.query(on: req.db)
            .with(\.$posts)
            .all()
    }
    
    func getTag(_ name: String) async throws -> BlogTag? {
        try await BlogTag.query(on: req.db)
            .filter(\.$name == name)
            .with(\.$posts)
            .first()
    }
    
    func getTag(using slug: String) async throws -> BlogTag? {
        try await BlogTag.query(on: req.db)
            .filter(\.$slugURL == slug)
            .with(\.$posts)
            .first()
    }
    
    func save(_ tag: BlogTag) async throws {
        try await tag.save(on: req.db)
    }
    
    func update(_ tag: BlogTag) async throws {
        try await tag.update(on: req.db)
    }
    
    func delete(_ tag: BlogTag) async throws {
        try await tag.delete(on: req.db)
    }
    
    func deleteTags(for post: BlogPost) async throws {
        let tags = try await post.$tags.query(on: req.db)
            .with(\.$posts)
            .all()
        for tag in tags {
            try await remove(tag, from: post)
        }
    }
    
    func remove(_ tag: BlogTag, from post: BlogPost) async throws {
        try await post.$tags.detach(tag, on: req.db)
    }
    
    func add(_ tag: BlogTag, to post: BlogPost) async throws {
        try await post.$tags.attach(tag, on: req.db)
    }
}
