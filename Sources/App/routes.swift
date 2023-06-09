import Vapor
import SteamPress

/// Register your application's routes here.
public func routes(_ app: Application) throws {

//    let authSessions = router.grouped(BlogAuthSessionsMiddleware())
    
//    authSessions.get { req -> Future<View> in
//        return BlogPost.query(on: req).filter(\.published == true).sort(\.created, .descending).range(0..<3).all().flatMap { posts in
//            let website = try req.getwebsite()
//            let postsWithShortSnippets = posts.map { $0.toPostWithShortSnippet() }
//            let context = HomepageContext(posts: postsWithShortSnippets, website: website)
//            return try req.view().render("index", context)
//        }
//    }
//
//    authSessions.get("about") { req -> Future<View> in
//        let website = try req.getwebsite()
//        let context = AboutPageContext(website: website)
//        return try req.view().render("about", context)
//    }
}

struct HomepageContext: Encodable {
    let posts: [PostWithShortSnippet]
    let website: website
}

struct AboutPageContext: Encodable {
    let aboutPage = true
    let website: website
}

struct website: Encodable {
    let loggedInUser: BlogUser.Public?
    let twitterHandler: String?
    let googleAnalytics: String?
    let disqusName: String?
    let webpageURL: String
}

//extension Request {
//    func getwebsite() throws -> website {
//        let disqusName = Environment.get("BLOG_DISQUS_NAME")
//        let twitterHandle = Environment.get("BLOG_SITE_TWITTER_HANDLE")
//        let googleAnalyticsIdentifier = Environment.get("BLOG_GOOGLE_ANALYTICS_IDENTIFIER")
//        let loggedInUser = try self.authenticated(BlogUser.self)
//        let webpageURL = self.http.url.absoluteString
//        return website(loggedInUser: loggedInUser, twitterHandler: twitterHandle, googleAnalytics: googleAnalyticsIdentifier, disqusName: disqusName, webpageURL: webpageURL)
//    }
//}
