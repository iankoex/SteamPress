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
        return try await viewRenderer.render("themes/default/admin/index", context)
    }
    
    public func createExploreView(usersCount: Int, errors: [String]?, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(errors: errors, usersCount: usersCount, site: site)
        return try await viewRenderer.render("themes/default/admin/explore", context)
    }
    
    public func createPagesView(usersCount: Int, errors: [String]?, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(errors: errors, usersCount: usersCount, site: site)
        return try await viewRenderer.render("themes/default/admin/pages", context)
    }
    
    public func createTagsView(tags: [BlogTag], usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let viewTags = try tags.toViewBlogTag(withPostsCount: true)
        let context = AdminPageContext(usersCount: usersCount, tags: viewTags, site: site)
        return try await viewRenderer.render("themes/default/admin/tags", context)
    }
    
    public func createTagView(errors: [String]?, tag: BlogTag?, usersCount: Int, site: SteamPressCore.GlobalWebsiteInformation) async throws -> Vapor.View {
        let tag = try? tag?.toViewBlogTag()
        let context = AdminPageContext(errors: errors, usersCount: usersCount, tag: tag, site: site)
        return try await viewRenderer.render("themes/default/admin/tag", context)
    }
    
    public func createEditTagView(tag: BlogTag, usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let viewTag = try tag.toViewBlogTag()
        let context = AdminPageContext(usersCount: usersCount, tag: viewTag, site: site)
        return try await viewRenderer.render("themes/default/admin/tag", context)
    }
    
    public func createPostsView(posts: [BlogPost], usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let viewPosts = try posts.toViewPosts()
        let context = AdminPageContext(usersCount: usersCount, posts: viewPosts, site: site)
        return try await viewRenderer.render("themes/default/admin/posts", context)
    }
    
    public func createPostView(errors: [String]?, tags: [BlogTag], post: BlogPost?, titleSupplied: String?, contentSupplied: String?, snippetSupplied: String?, site: GlobalWebsiteInformation) async throws -> View {
        let viewPost = try post?.toViewPost()
        let viewTags = try tags.toViewBlogTag()
        let context = CreatePostPageContext(post: viewPost, tags: viewTags, titleSupplied: titleSupplied, contentSupplied: contentSupplied, snippetSupplied: snippetSupplied, errors: errors, site: site)
        return try await viewRenderer.render("themes/default/admin/post", context)
    }
    
    public func createResetPasswordView(errors: [String]?, site: GlobalWebsiteInformation) async throws -> View {
        let context = ResetPasswordPageContext(errors: errors, site: site)
        return try await viewRenderer.render("themes/default/admin/resetPassword", context)
    }
    
    public func loginView(loginWarning: Bool, errors: [String]?, email: String?, rememberMe: Bool, requireName: Bool, site: GlobalWebsiteInformation) async throws -> View {
        let context = LoginPageContext(errors: errors, loginWarning: loginWarning, email: email, rememberMe: rememberMe, requireName: requireName, site: site)
        return try await viewRenderer.render("themes/default/admin/login", context)
    }
    
    public func createMembersView(users: [BlogUser.Public], usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(usersCount: usersCount, users: users, site: site)
        return try await viewRenderer.render("themes/default/admin/members", context)
    }
    
    public func createCreateMemberView(userData: CreateUserData?, errors: [String]?, usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(errors: errors, usersCount: usersCount, userData: userData, site: site)
        return try await viewRenderer.render("themes/default/admin/member", context)
    }
    
    public func createSettingsView(errors: [String]?, usersCount: Int, site: GlobalWebsiteInformation) async throws -> View {
        let context = AdminPageContext(errors: errors, usersCount: usersCount, site: site)
        return try await viewRenderer.render("themes/default/admin/settings", context)
    }
}
