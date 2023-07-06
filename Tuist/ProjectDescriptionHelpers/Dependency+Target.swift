import ProjectDescription

public extension TargetDependency {
    struct Feature {}
    struct Core {}
    struct Domain {}
    struct Shared {}
}

public extension TargetDependency.Feature {
    static let SigninFeature = TargetDependency.feature(name: "SigninFeature")
    static let BaseFeature = TargetDependency.feature(name: "BaseFeature")
    static let RootFeature = TargetDependency.feature(name: "RootFeature")
    static let SignupFeature = TargetDependency.feature(name: "SignupFeature")
    static let FindPasswordFeature = TargetDependency.feature(name: "FindPasswordFeature")
    static let FindIdFeature = TargetDependency.feature(name: "FindIdFeature")
    static let PhoneNumberAuthFeature = TargetDependency.feature(name: "PhoneNumberAuthFeature")
    static let HomeFeature = TargetDependency.feature(name: "HomeFeature")
    static let ProfileFeature = TargetDependency.feature(name: "ProfileFeature")
    static let SettingFeature = TargetDependency.feature(name: "SettingFeature")
    static let EditProfileFeature = TargetDependency.feature(name: "EditProfileFeature")
    static let SelectPhotoFeature = TargetDependency.feature(name: "SelectPhotoFeature")
    static let AddressFeature = TargetDependency.feature(name: "AddressFeature")
    static let MoviesDetailFeature = TargetDependency.feature(name: "MoviesDetailFeature")
    static let CrowdFundingFeature = TargetDependency.feature(name: "CrowdFundingFeature")
}

public extension TargetDependency.Core {
    static let DesignSystem = TargetDependency.core(name: "DesignSystem")
    static let JwtStore = TargetDependency.core(name: "JwtStore")
}

public extension TargetDependency.Domain {
    static let RouterDomain = TargetDependency.domain(name: "RouterDomain")
}

public extension TargetDependency.Shared {
    static let GlobalThirdPartyLib = TargetDependency.shared(name: "GlobalThirdPartyLib")
    static let Utility = TargetDependency.shared(name: "Utility")
}
