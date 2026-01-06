// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SwiftComponentKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftComponentKitUI",
            targets: ["SwiftComponentKitUI"]
        ),
        .library(
            name: "SwiftComponentKitFoundation",
            targets: ["SwiftComponentKitFoundation"]
        ),
        .library(
            name: "SwiftComponentKitImage",
            targets: ["SwiftComponentKitImage"]
        ),
        .library(
            name: "SwiftComponentKitNetwork",
            targets: ["SwiftComponentKitNetwork"]
        ),
        .library(
            name: "SwiftComponentKitStorage",
            targets: ["SwiftComponentKitStorage"]
        ),
        .library(
            name: "SwiftComponentKitUtils",
            targets: ["SwiftComponentKitUtils"]
        ),
        .library(
            name: "SwiftComponentKitLocalization",
            targets: ["SwiftComponentKitLocalization"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .exact("5.4.4")),
    ],
    targets: [
        .target(
            name: "SwiftComponentKitUI",
            dependencies: ["SnapKit"],
            path: "SwiftComponentKitUI/Sources",
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS]))
            ]
        ),
        .target(
            name: "SwiftComponentKitFoundation",
            dependencies: [],
            path: "SwiftComponentKitFoundation/Sources",
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS]))
            ]
        ),
        .target(
            name: "SwiftComponentKitImage",
            dependencies: [],
            path: "SwiftComponentKitImage/Sources",
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS]))
            ]
        ),
        .target(
            name: "SwiftComponentKitNetwork",
            dependencies: ["Alamofire"],
            path: "SwiftComponentKitNetwork/Sources",
            linkerSettings: [
                .linkedFramework("Combine", .when(platforms: [.iOS]))
            ]
        ),
        .target(
            name: "SwiftComponentKitStorage",
            dependencies: ["SwiftComponentKitUtils", "SwiftComponentKitFoundation"],
            path: "SwiftComponentKitStorage/Sources"
        ),
        .target(
            name: "SwiftComponentKitUtils",
            dependencies: [],
            path: "SwiftComponentKitUtils/Sources",
            linkerSettings: [
                .linkedFramework("UIKit", .when(platforms: [.iOS])),
                .linkedFramework("SystemConfiguration", .when(platforms: [.iOS]))
            ]
        ),
        .target(
            name: "SwiftComponentKitLocalization",
            dependencies: [],
            path: "SwiftComponentKitLocalization/Sources"
        ),
    ]
)

