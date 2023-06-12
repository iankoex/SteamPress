import SteamPressCore

struct AdminPageContext: Encodable {
    let errors: [String]?
    let usersCount: Int
    let posts: [ViewBlogPost]?
    let tags: [ViewBlogTag]?
    let tag: ViewBlogTag?
    let site: GlobalWebsiteInformation
    
    init(
        errors: [String]? = nil,
        usersCount: Int,
        posts: [ViewBlogPost]? = nil,
        tags: [ViewBlogTag]? = nil,
        tag: ViewBlogTag? = nil,
        site: GlobalWebsiteInformation
    ) {
        self.errors = errors
        self.usersCount = usersCount
        self.posts = posts
        self.tags = tags
        self.tag = tag
        self.site = site
    }
}
