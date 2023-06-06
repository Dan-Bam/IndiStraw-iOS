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
        
        .Core.JwtStore,
        .Core.DesignSystem,
        
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
