// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "MobilliumToolTips",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MobilliumToolTips",
            targets: ["MobilliumToolTips"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/mobillium/MobilliumBuilders.git", from: "1.5.0"),
        .package(url: "https://github.com/roberthein/TinyConstraints.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "MobilliumToolTips",
            dependencies: ["MobilliumBuilders", "TinyConstraints"],
            path: "Sources",
            resources: [
                .process("MobilliumToolTips/*")
            ]
        )
    ]
)
