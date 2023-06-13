import SteamPressCore

public struct LoginPageContext: Encodable {
    public let errors: [String]?
    public let loginWarning: Bool
    public let email: String?
    public let rememberMe: Bool
    public let requireName: Bool
    public let site: GlobalWebsiteInformation
}
