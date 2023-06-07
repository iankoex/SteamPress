// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SteamPressExample",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", exact: "2.6.0"),
//        .package(url: "https://github.com/iankoex/SteamPress.git", from: "2.0.3"),
        .package(path: "../SteamPress"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
        .package(url: "https://github.com/brokenhandsio/leaf-error-middleware.git", from: "4.1.1"),
        .package(url: "https://github.com/brokenhandsio/VaporSecurityHeaders.git", from: "4.1.0"),
        .package(url: "https://github.com/vapor-community/leaf-markdown.git", from: "3.0.1")
    ],
    targets: [
        .target(name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "SteamPress", package: "SteamPress"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "LeafErrorMiddleware", package: "leaf-error-middleware"),
                .product(name: "VaporSecurityHeaders", package: "VaporSecurityHeaders"),
                .product(name: "LeafMarkdown", package: "leaf-markdown")
            ]),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
