import SteamPressCore

struct BlogIndexPageContext: Encodable {
    let posts: [ViewBlogPost]
    let site: GlobalWebsiteInformation
    let blogIndexPage = true
    let paginationTagInformation: PaginationTagInformation
}
