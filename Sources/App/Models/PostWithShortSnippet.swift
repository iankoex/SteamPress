import Foundation
import SteamPress

struct PostWithShortSnippet: Codable {
    var blogID: UUID?
    var title: String
    var contents: String
    var author: UUID
    var created: Date
    var lastEdited: Date?
    var slugUrl: String
    var published: Bool
    var shortSnippet: String
}

extension BlogPost {
    func toPostWithShortSnippet() -> PostWithShortSnippet {
        return PostWithShortSnippet(blogID: self.id, title: self.title, contents: self.contents, author: self.author.id ?? UUID(), created: self.created, lastEdited: self.lastEdited, slugUrl: self.slugUrl, published: self.published, shortSnippet: self.shortSnippet())
    }
}
