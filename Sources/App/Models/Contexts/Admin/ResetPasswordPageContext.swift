import SteamPressCore

struct ResetPasswordPageContext: Encodable {
    let errors: [String]?
    let passwordError: Bool?
    let confirmPasswordError: Bool?
    let site: GlobalWebsiteInformation
}
