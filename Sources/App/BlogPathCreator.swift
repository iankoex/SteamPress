public struct BlogPathCreator {

    static let blogPath: String? = nil

    static func createPath(for path: String?, query: String? = nil) -> String {
        var createdPath = constructPath(from: path)

        if let query = query {
            createdPath = "\(createdPath)?\(query)"
        }

        return createdPath
    }

    fileprivate static func constructPath(from path: String?) -> String {
        if path == blogPath {
            if let index = blogPath {
                return "/\(index)/"
            } else {
                return "/"
            }
        }
        if let index = blogPath {
            if let pathSuffix = path {
                return "/\(index)/\(pathSuffix)/"
            } else {
                return "/\(index)/"
            }
        } else {
            guard let path = path else {
                return "/"
            }
            return "/\(path)/"
        }
    }
}
