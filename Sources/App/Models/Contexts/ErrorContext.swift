import Vapor

struct ErrorContext: Codable {
    var status: HTTPStatus
    var error: String
}
