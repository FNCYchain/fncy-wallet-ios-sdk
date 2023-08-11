// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FncyWallet",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "FncyWallet",
                 targets: ["FncyWallet"])
    ],
    dependencies: [
        .package(name: "Alamofire",
                  url: "https://github.com/Alamofire/Alamofire.git",
                  Version(5, 7, 0)..<Version(6, 0, 0)),
        .package(name: "SwiftyRSA",
                  url: "https://github.com/TakeScoop/SwiftyRSA.git",
                  Version(1, 7, 0)..<Version(2, 0, 0))
    ],
    targets: [
        .target(name: "FncyWallet",
		dependencies: ["Alamofire",
				"SwiftyRSA"
		],
                path: "FncyWallet/Classes")
    ],
    swiftLanguageVersions: [.v5]
)
