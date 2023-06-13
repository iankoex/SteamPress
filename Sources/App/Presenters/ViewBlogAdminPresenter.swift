import Vapor
import SteamPressCore

public struct ViewBlogAdminPresenter: BlogAdminPresenter {
    
    let viewRenderer: ViewRenderer
    
    public init(_ req: Request) {
        self.viewRenderer = req.view
    }
    
    public func `for`(_ request: Request) -> BlogAdminPresenter {
        return self
    }
    
    public func createIndexView(usersCount: Int, errors: [String]?, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(errors: errors, usersCount: usersCount, site: site)
        return try await viewRenderer.render("blog/admin/index", context)
    }
    
    public func createExploreView(usersCount: Int, errors: [String]?, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(errors: errors, usersCount: usersCount, site: site)
        return try await viewRenderer.render("blog/admin/explore", context)
    }
    
    public func createPagesView(usersCount: Int, errors: [String]?, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(errors: errors, usersCount: usersCount, site: site)
        return try await viewRenderer.render("blog/admin/pages", context)
    }
    
    public func createTagsView(tags: [BlogTag], usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let viewTags = try tags.toViewBlogTag(withPostsCount: true)
        let context = AdminPageContext(usersCount: usersCount, tags: viewTags, site: site)
        return try await viewRenderer.render("blog/admin/tags", context)
    }
    
    public func createCreateTagView(usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(usersCount: usersCount, site: site)
        return try await viewRenderer.render("blog/admin/tagView", context)
    }
    
    public func createEditTagView(tag: BlogTag, usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let viewTag = try tag.toViewBlogTag()
        let context = AdminPageContext(usersCount: usersCount, tag: viewTag, site: site)
        return try await viewRenderer.render("blog/admin/tagView", context)
    }
    
    public func createPostsView(posts: [BlogPost], usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let viewPosts = try posts.toViewPosts()
        let context = AdminPageContext(usersCount: usersCount, posts: viewPosts, site: site)
        return try await viewRenderer.render("blog/admin/posts", context)
    }
    
    public func createPostView(errors: [String]?, title: String?, contents: String?, slugURL: String?, tags: [String], isEditing: Bool, post: BlogPost?, isDraft: Bool?, titleError: Bool, contentsError: Bool, site: GlobalWebsiteInformation) async throws -> View {
        if isEditing {
            guard post != nil else {
                throw SteamPressError(identifier: "ViewBlogAdminPresenter", "Blog Post is empty whilst editing")
            }
        }
        let postPathSuffix = BlogPathCreator.createPath(for: "posts")
        let postPathPrefix = site.url.appending(postPathSuffix)
        let pageTitle = isEditing ? "Edit Blog Post" : "Create Blog Post"
        let context = CreatePostPageContext(title: pageTitle, editing: isEditing, post: post, draft: isDraft ?? false, errors: errors, titleSupplied: title, contentsSupplied: contents, tagsSupplied: tags, slugURLSupplied: slugURL, titleError: titleError, contentsError: contentsError, postPathPrefix: postPathPrefix, site: site)
        return try await viewRenderer.render("blog/admin/createPost", context)
    }
    
    public func createResetPasswordView(errors: [String]?, site: GlobalWebsiteInformation) async throws -> View {
        let context = ResetPasswordPageContext(errors: errors, site: site)
        return try await viewRenderer.render("blog/admin/resetPassword", context)
    }
    
    public func loginView(loginWarning: Bool, errors: [String]?, email: String?, rememberMe: Bool, requireName: Bool, site: GlobalWebsiteInformation) async throws -> View {
        let context = LoginPageContext(errors: errors, loginWarning: loginWarning, email: email, rememberMe: rememberMe, requireName: requireName, site: site)
        return try await viewRenderer.render("blog/admin/login", context)
    }
    
    public func createMembersView(users: [BlogUser.Public], usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(usersCount: usersCount, users: users, site: site)
        return try await viewRenderer.render("blog/admin/members", context)
    }
    
    public func createCreateMemberView(userData: CreateUserData?, errors: [String]?, usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(errors: errors, usersCount: usersCount, userData: userData, site: site)
        return try await viewRenderer.render("blog/admin/memberView", context)
    }
}