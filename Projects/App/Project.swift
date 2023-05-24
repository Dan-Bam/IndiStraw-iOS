import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: Environment.appName,
    platform: .iOS,
    product: .app,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.SigninFeature,
        
        .Core.DesignSystem,
        
        .Shared.GlobalThirdPartyLib
    ],
    resources: ["Resources/**"],
    infoPlist: .file(path: "Support/Info.plist")
)
