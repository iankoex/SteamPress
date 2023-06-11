import SteamPress

struct AuthorPageContext: Encodable {
    let author: BlogUser.Public
    let posts: [ViewBlogPost]
    let site: GlobalWebsiteInformation
    let myProfile: Bool
    let profilePage = true
    let postCount: Int
    let paginationTagInformation: PaginationTagInformation
}
