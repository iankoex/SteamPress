import SteamPressCore

struct CreatePostPageContext: Encodable {
    let post: ViewBlogPost?
    let tags: [ViewBlogTag]
    let titleSupplied: String?
    let contentSupplied: String?
    let excerptSupplied: String?
    let errors: [String]?
    let site: GlobalWebsiteInformation
}
