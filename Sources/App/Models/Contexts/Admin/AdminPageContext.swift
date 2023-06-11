import SteamPressCore

struct AdminPageContext: Encodable {
    let errors: [String]?
    let usersCount: Int
    let posts: [ViewBlogPost]?
    let site: GlobalWebsiteInformation
}
