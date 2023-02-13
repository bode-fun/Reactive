// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Reactive",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Reactive",
            targets: ["Reactive"]
        ),
        .executable(
            name: "ReactiveDemo",
            targets: ["ReactiveDemo"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Reactive",
            dependencies: []
        ),
        .executableTarget(
            name: "ReactiveDemo",
            dependencies: [
                .target(name: "Reactive"),
            ]
        ),
        .testTarget(
            name: "ReactiveTests",
            dependencies: ["Reactive"]
        ),
    ]
)
