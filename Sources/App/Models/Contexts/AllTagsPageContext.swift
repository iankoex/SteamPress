import SteamPress

struct AllTagsPageContext: Encodable {
    let title: String
    let tags: [BlogTagWithPostCount]
    let site: GlobalWebsiteInformation
}
