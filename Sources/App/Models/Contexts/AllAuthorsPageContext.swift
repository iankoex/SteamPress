import SteamPress

struct AllAuthorsPageContext: Encodable {
    let site: GlobalWebsiteInformation
    let authors: [ViewBlogAuthor]
}
