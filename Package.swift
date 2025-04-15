// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdPopcornSSP",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AdPopcornSSPSDK",
            targets: ["AdPopcornSSPSDK"]),
        
        .library(
            name: "APSDKMediationAdFit",
            targets: ["APSDKMediationAdFitWrapper"]), // <- Wrapper 타겟을 외부로 노출
            
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
//        .package(url: "https://github.com/adfit/adfit-spm.git", from: "3.18.6"),
        .package(name: "AdFitSDK",
                 url: "https://github.com/adfit/adfit-spm.git",
                 from: "3.18.6")
        
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(name: "AdPopcornSSPSDK",
                      path: "xcframework/AdPopcornSSPSDK.xcframework"),
        
        // AdFit mediation 모듈 본체 (추가 UI 로직이 없으면 이걸로 충분)
        .binaryTarget(name: "APSDKMediationAdFit",
                      path: "xcframework/Mediation/APSDKMediationAdFit.xcframework"),

        // Wrapper 타겟: 외부에서 사용하는 진짜 타겟은 얘!
        .target(
            name: "APSDKMediationAdFitWrapper",
            dependencies: ["AdPopcornSSPSDK",
                           "APSDKMediationAdFit",
                .product(name: "AdFitSDK",
                         package: "AdFitSDK"),
            ],
            path: "xcframework/APSDKMediationAdFitWrapper"
        ),
    ]
)
