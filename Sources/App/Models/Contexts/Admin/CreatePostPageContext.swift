import SteamPressCore

struct CreatePostPageContext: Encodable {
    let post: ViewBlogPost?
    let tags: [ViewBlogTag]
    let errors: [String]?
    let site: GlobalWebsiteInformation
}
