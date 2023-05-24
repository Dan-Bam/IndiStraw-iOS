import ProjectDescription

public extension TargetDependency {
    struct Feature {}
    struct Core {}
    struct Shared {}
}

public extension TargetDependency.Feature {
    static let SigninFeature = TargetDependency.feature(name: "SigninFeature")
    static let BaseFeature = TargetDependency.feature(name: "BaseFeature")
}

public extension TargetDependency.Shared {
    static let GlobalThirdPartyLib = TargetDependency.shared(name: "GlobalThirdPartyLib")
}
