import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Environment.appName,
    platform: .iOS,
    product: .app,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.RootFeature,
        .Feature.SigninFeature,
        .Feature.SignupFeature,
        .Feature.FindPasswordFeature,
        .Feature.FindIdFeature,
        .Feature.PhoneNumberAuthFeature,
        .Feature.HomeFeature,
        .Feature.ProfileFeature,
        .Feature.SettingFeature,
        .Feature.EditProfileFeature,
        .Feature.SelectPhotoFeature,
        .Feature.AddressFeature,
        .Feature.AddMoviesFeature,
        
        .Core.JwtStore,
        .Core.DesignSystem,
        
        .Domain.AuthDomain,
        
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
