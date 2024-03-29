import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: [
        .remote(
            url: "https://github.com/SnapKit/SnapKit",
            requirement: .upToNextMajor(from: "5.6.0")),
        .remote(
            url: "https://github.com/devxoul/Then",
            requirement: .upToNextMajor(from: "3.0.0")),
        .remote(
            url: "https://github.com/onevcat/Kingfisher",
            requirement: .upToNextMajor(from: "7.6.2")),
        .remote(
            url: "https://github.com/ReactiveX/RxSwift",
            requirement: .upToNextMajor(from: "6.5.0")),
        .remote(
            url: "https://github.com/Alamofire/Alamofire",
            requirement: .upToNextMajor(from: "5.6.4")),
        .remote(
            url: "https://github.com/Swinject/Swinject",
            requirement: .upToNextMajor(from: "2.8.3")),
        .remote(
            url: "https://github.com/RxSwiftCommunity/RxGesture",
            requirement: .upToNextMajor(from: "4.0.4")),
        .remote(
            url: "https://github.com/Mindohyeon/ColorfulLog",
            requirement: .upToNextMajor(from: "0.1.0"))
    ],
    platforms: [.iOS]
)
