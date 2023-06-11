import SteamPressCore

struct TagPageContext: Encodable {
    let tag: BlogTag
    let site: GlobalWebsiteInformation
    let posts: [ViewBlogPost]
    let tagPage = true
    let postCount: Int
    let paginationTagInformation: PaginationTagInformation
}
