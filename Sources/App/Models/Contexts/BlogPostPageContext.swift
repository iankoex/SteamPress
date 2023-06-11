import SteamPressCore

struct BlogPostPageContext: Encodable {
    let title: String
    let post: ViewBlogPost
    let blogPostPage = true
    let site: GlobalWebsiteInformation
}
