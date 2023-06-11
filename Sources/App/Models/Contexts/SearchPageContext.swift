import SteamPressCore

struct SearchPageContext: Encodable {
    let searchTerm: String?
    let posts: [ViewBlogPost]
    let totalResults: Int
    let site: GlobalWebsiteInformation
    let paginationTagInformation: PaginationTagInformation
}
