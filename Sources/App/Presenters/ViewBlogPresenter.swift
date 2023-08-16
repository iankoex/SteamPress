import Vapor
import SteamPressCore

public struct ViewBlogPresenter: BlogPresenter {
    
    let viewRenderer: ViewRenderer
    
    public init(_ req: Request) {
        self.viewRenderer = req.view
    }
   
    public func `for`(_ req: Request) -> BlogPresenter {
        return self
    }

    public func indexView(posts: [BlogPost], site: GlobalWebsiteInformation, paginationTagInfo: PaginationTagInformation) async throws -> View {
        let viewPosts = try posts.toViewPosts()
        let context = BlogIndexPageContext(posts: viewPosts, site: site, paginationTagInformation: paginationTagInfo)
        return try await viewRenderer.render("Themes/default/index", context)
    }

    public func postView(post: BlogPost, site: GlobalWebsiteInformation) async throws -> View {
        let viewPost = try post.toViewPost()
        let context = BlogPostPageContext(title: post.title, post: viewPost, site: site)
        return try await viewRenderer.render("Themes/default/post", context)
    }

    public func allAuthorsView(authors: [BlogUser.Public], authorPostCounts: [UUID: Int], site: GlobalWebsiteInformation) async throws -> View {
        var viewAuthors = try authors.map { user -> ViewBlogAuthor in
            guard let userID = user.id else {
                throw SteamPressError(identifier: "ViewBlogPresenter", "User ID Was Not Set")
            }
            return ViewBlogAuthor(userID: userID, name: user.name, username: user.username, profilePicture: user.profilePicture, twitterHandle: user.twitterHandle, biography: user.biography, tagline: user.tagline, postCount: authorPostCounts[userID] ?? 0)
            
        }
        viewAuthors.sort { $0.postCount > $1.postCount }
        let context = AllAuthorsPageContext(site: site, authors: viewAuthors)
        return try await viewRenderer.render("Themes/default/authors", context)
    }
    
    public func authorView(author: BlogUser.Public, posts: [BlogPost], postCount: Int, site: GlobalWebsiteInformation, paginationTagInfo: PaginationTagInformation) async throws -> View {
        let myProfile: Bool
        if let loggedInUser = site.loggedInUser {
            myProfile = loggedInUser.id == author.id
        } else {
            myProfile = false
        }
        let viewPosts = try posts.toViewPosts()
        let context = AuthorPageContext(author: author, posts: viewPosts, site: site, myProfile: myProfile, postCount: postCount, paginationTagInformation: paginationTagInfo)
        return try await viewRenderer.render("Themes/default/author", context)
    }

    public func allTagsView(tags: [BlogTag], tagPostCounts: [UUID: Int], site: GlobalWebsiteInformation) async throws -> View {
        var viewTags = try tags.map { tag -> BlogTagWithPostCount in
            guard let tagID = tag.id else {
                throw SteamPressError(identifier: "ViewBlogPresenter", "Tag ID Was Not Set")
            }
            guard let urlEncodedName = tag.name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
                throw SteamPressError(identifier: "ViewBlogPresenter", "Failed to URL encoded tag name")
            }
            return BlogTagWithPostCount(id: tagID, name: tag.name, postCount: tagPostCounts[tagID] ?? 0, urlEncodedName: urlEncodedName)
        }
        viewTags.sort { $0.postCount > $1.postCount }
        let context = AllTagsPageContext(title: "All Tags", tags: viewTags, site: site)
        return try await viewRenderer.render("Themes/default/tags", context)
    }

    public func tagView(tag: BlogTag, posts: [BlogPost], authors: [BlogUser.Public], totalPosts: Int, site: GlobalWebsiteInformation, paginationTagInfo: PaginationTagInformation) async throws -> View {
        let viewPosts = try posts.toViewPosts()
        let context = TagPageContext(tag: tag, site: site, posts: viewPosts, postCount: totalPosts, paginationTagInformation: paginationTagInfo)
        return try await viewRenderer.render("Themes/default/tag", context)
    }

    public func searchView(totalResults: Int, posts: [BlogPost], authors: [BlogUser.Public], tags: [BlogTag], searchTerm: String?, site: GlobalWebsiteInformation, paginationTagInfo: PaginationTagInformation) async throws -> View {
        let viewPosts = try posts.toViewPosts()
        let context = SearchPageContext(searchTerm: searchTerm, posts: viewPosts, totalResults: totalResults, site: site, paginationTagInformation: paginationTagInfo)
        return try await viewRenderer.render("Themes/default/search", context)
    }
}
