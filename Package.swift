// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "StandupTimer",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .executable(
            name: "StandupTimer",
            targets: ["StandupTimer"]
        )
    ],
    targets: [
        .executableTarget(
            name: "StandupTimer",
            path: "Sources"
        )
    ]
)
