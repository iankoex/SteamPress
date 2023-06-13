import SteamPressCore

struct ResetPasswordPageContext: Encodable {
    let errors: [String]?
    let site: GlobalWebsiteInformation
}
