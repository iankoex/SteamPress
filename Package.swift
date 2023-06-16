// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SteamPress",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", exact: "2.6.0"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0"),
//        .package(url: "https://github.com/iankoex/steampress-core.git", from: "2.0.8"),
        .package(path: "../steampress-core"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
        .package(url: "https://github.com/brokenhandsio/leaf-error-middleware.git", from: "4.1.1")
    ],
    targets: [
        .target(name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
                .product(name: "SteamPressCore", package: "steampress-core"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "LeafErrorMiddleware", package: "leaf-error-middleware")
            ]),
        .executableTarget(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
