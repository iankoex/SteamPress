import SteamPressCore

struct AdminPageContext: Encodable {
    let errors: [String]?
    let usersCount: Int
    let posts: [ViewBlogPost]?
    let tags: [ViewBlogTag]?
    let tag: ViewBlogTag?
    let users: [BlogUser.Public]?
    let userData: CreateUserData?
    let site: GlobalWebsiteInformation
    
    init(
        errors: [String]? = nil,
        usersCount: Int,
        posts: [ViewBlogPost]? = nil,
        tags: [ViewBlogTag]? = nil,
        tag: ViewBlogTag? = nil,
        users: [BlogUser.Public]? = nil,
        userData: CreateUserData? = nil,
        site: GlobalWebsiteInformation
    ) {
        self.errors = errors
        self.usersCount = usersCount
        self.posts = posts
        self.tags = tags
        self.tag = tag
        self.users = users
        self.userData = userData
        self.site = site
    }
}
