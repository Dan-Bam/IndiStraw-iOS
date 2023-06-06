import ProjectDescription

public extension TargetDependency {
    struct Feature {}
    struct Core {}
    struct Shared {}
}

public extension TargetDependency.Feature {
    static let SigninFeature = TargetDependency.feature(name: "SigninFeature")
    static let BaseFeature = TargetDependency.feature(name: "BaseFeature")
    static let RootFeature = TargetDependency.feature(name: "RootFeature")
    static let SignupFeature = TargetDependency.feature(name: "SignupFeature")
}

public extension TargetDependency.Core {
    static let DesignSystem = TargetDependency.core(name: "DesignSystem")
    static let JwtStore = TargetDependency.core(name: "JwtStore")
}

public extension TargetDependency.Shared {
    static let GlobalThirdPartyLib = TargetDependency.shared(name: "GlobalThirdPartyLib")
    static let Utility = TargetDependency.shared(name: "Utility")
}
