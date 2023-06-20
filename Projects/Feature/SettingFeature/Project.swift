import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "SettingFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.EditProfileFeature,
        
        .Core.DesignSystem,
        .Domain.AuthDomain,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
