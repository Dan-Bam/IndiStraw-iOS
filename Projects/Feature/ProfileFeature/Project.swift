import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ProfileFeature",
    product: .staticLibrary,
    dependencies: [
        .Feature.BaseFeature,
        .Feature.SettingFeature,
        .Core.DesignSystem,
        .Domain.AuthDomain,
        .Shared.Utility,
        .Shared.GlobalThirdPartyLib
    ]
)
