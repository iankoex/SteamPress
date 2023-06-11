import SteamPressCore

struct AllTagsPageContext: Encodable {
    let title: String
    let tags: [BlogTagWithPostCount]
    let site: GlobalWebsiteInformation
}
