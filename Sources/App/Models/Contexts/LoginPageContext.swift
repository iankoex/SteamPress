import SteamPressCore

public struct LoginPageContext: Encodable {
    public let errors: [String]?
    public let loginWarning: Bool
    public let username: String?
    public let usernameError: Bool
    public let passwordError: Bool
    public let rememberMe: Bool
    public let site: GlobalWebsiteInformation
}
